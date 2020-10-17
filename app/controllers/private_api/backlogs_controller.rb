module PrivateApi
  class BacklogsController < ApiController
    COLUMN_KEYS = %i(id name color position parent_id)
    ITEM_KEYS = %i(id name point priority description child_backlog_id)
    TAG_KEYS = %i(id name)
    USER_KEYS = %i(id name)

    skip_before_action :verify_authenticity_token

    before_action :parse_request_body, only: [:update_column_location, :update_item_location]
    before_action :find_backlog
    before_action :check_session

    def get_columns_and_items
      render json: {
        status: 200,
        message: {
          columns: get_columns_and_association_items,
          tags: get_normalize_backlog_tag_records,
          users: get_normalize_user_records,
          child_backlogs: get_normalize_child_backlogs,
          parent_backlog_columns: get_normalize_parent_backlog_columns,
          allocated_items_from_parent_backlog: get_normalize_allocated_items_from_parent_backlog
        },
      }.to_json
    rescue
      render json: "internal server error", status: :internal_server_error
    end

    def update_item_location
      status = _update_item_location

      case status
      when 200
        render json: { status: 200, message: "ok" }.to_json
      else
        render status: :internal_server_error, json: { status: 500, message: "Internal Server Error" }.to_json
      end
    end

    def update_column_location
      status = _update_column_location

      case status
      when 200
        render json: { status: 200, message: "ok" }.to_json
      else
        render status: :internal_server_error, json: { status: 500, message: "Internal Server Error" }.to_json
      end
    end

    private

    def parse_request_body
      body = request.body.read
      @params ||= JSON.parse(body, symbolize_names: true)
    end

    def find_backlog
      @backlog = Backlog.find_by(id: params[:id])
    end

    concerning :GetMethod do
      def get_columns_and_association_items
        return get_normalize_info(@backlog.backlog_columns, COLUMN_KEYS, %i(items)).sort_by { |column| column[:position] }
      end

      def get_items_by_column(column)
        return get_normalize_info(column.backlog_items, ITEM_KEYS, %i(tags users)).sort_by { |item| item[:priority] }
      end

      def get_normalize_info(obj_arrays, keys, additional_obj_keys)
        info = obj_arrays.map do |obj|
          info = keys.reduce({}) { |memo, key|
            memo.tap { |me| me[key] = obj[key] }
          }

          additional_obj_keys.each do |key|
            info[key] = additional_obj(key, obj)
          end

          info
        end

        return info
      end

      def additional_obj(symbolize_key, obj)
        case symbolize_key
        when :tags
          # obj -> backlog_item
          obj.backlog_tags.pluck(:id)
        when :users
          # obj -> backlog_item
          obj.users.pluck(:id)
        when :items
          get_items_by_column(obj)
        else
          []
        end
      end

      %w(backlog_tag user).each do |model_name|
        define_method("get_normalize_#{model_name}_records") do |root_key: :id, attr_names: %i(name)|
          objs = send("#{model_name}_objs")
          normalize_obj_records(objs, root_key, attr_names)
        end
      end

      def normalize_obj_records(objs, root_key, attr_names)
        return objs.pluck(root_key, *attr_names).reduce({}) { |memo, obj|
                 h = {}
                 attr_names.each.with_index(1) { |attr_name, idx| h["#{attr_name}".intern] = obj[idx] }

                 memo.tap { |me| me["#{obj.first}".intern] = h }
               }
      end

      def backlog_tag_objs
        return BacklogTag.where(backlog_id: @backlog.id)
      end

      def user_objs
        return @backlog.users
      end

      def get_normalize_child_backlogs
        children = @backlog.children
        return {} if children.nil?
        return normalize_obj_records(children, :id, %i(name))
      end

      def get_normalize_parent_backlog_columns
        parent = @backlog.parent
        return {} if parent.nil?
        return normalize_obj_records(parent.backlog_columns, :id, %i(name))
      end

      def get_normalize_allocated_items_from_parent_backlog
        return normalize_obj_records(@backlog.child_backlog_items, :id, %i(name))
      end

    end

    concerning :UpdateMethod do
      ####################
      # for backlog_item #
      ####################
      def _update_item_location
        update_target_item = BacklogItem.find_by_id(@params[:backlog_item_id])
        new_column_id = @params[:new_column_id]
        old_column_id = update_target_item.backlog_column_id
        @new_priority = @params[:new_priority]
        @old_priority = update_target_item.priority

        begin
          @shift_target_items = BacklogColumn.find_by_id(old_column_id).backlog_items

          ActiveRecord::Base.transaction do
            if old_column_id != new_column_id
              update_priority_across_columns(new_column_id)
            elsif @new_priority > @old_priority
              raise_priority
            elsif @old_priority > @new_priority
              lower_priority
            end

            update_target_item.update!(backlog_column_id: new_column_id, priority: @new_priority)

            recursive_move_parent_items(update_target_item) if old_column_id != new_column_id
          end

          return 200
        rescue
          return 500
        end
      end

      def update_priority_across_columns(new_column_id)
        new_column_items = BacklogColumn.find_by_id(new_column_id).backlog_items

        decrement_backlog_items_priority(item_ids(@shift_target_items, @old_priority + 1, @shift_target_items.maximum(:priority)))
        increment_backlog_items_priority(item_ids(new_column_items, @new_priority, new_column_items.maximum(:priority)))
      end

      def raise_priority
        decrement_backlog_items_priority(item_ids(@shift_target_items, @old_priority + 1, @new_priority))
      end

      def lower_priority
        increment_backlog_items_priority(item_ids(@shift_target_items, @new_priority, @old_priority - 1))
      end

      def item_ids(column_items, beginning_of_range, end_of_range)
        return column_items.where(priority: beginning_of_range..end_of_range).pluck(:id)
      end

      def increment_backlog_items_priority(target_ids)
        BacklogItem.increment_counter(:priority, target_ids)
      end

      def decrement_backlog_items_priority(target_ids)
        BacklogItem.decrement_counter(:priority, target_ids)
      end

      ######################
      # for backlog_column #
      ######################
      def _update_column_location
        #{
        #  backlog_id: 3,
        #  backlog_column_id: 33,
        #  new_position: 3
        #}
        update_target_column = BacklogColumn.find_by_id(@params[:backlog_column_id])
        @new_position = @params[:new_position]
        @old_position = update_target_column.position

        @shift_target_columns = BacklogColumn.where(backlog_id: params[:id])
        begin
          ActiveRecord::Base.transaction do
            if @old_position < @new_position
              raise_position
            elsif @new_position < @old_position
              lower_position
            end

            update_target_column.update!(position: @new_position)
          end

          return 200
        rescue
          return 500
        end
      end

      def raise_position
        decrement_backlog_columns_position(column_ids(@shift_target_columns, @old_position + 1, @new_position))
      end

      def lower_position
        increment_backlog_columns_position(column_ids(@shift_target_columns, @new_position, @old_position - 1))
      end

      def column_ids(columns, beginning_of_range, end_of_range)
        return columns.where(position: beginning_of_range..end_of_range).pluck(:id)
      end

      def increment_backlog_columns_position(target_ids)
        BacklogColumn.increment_counter(:position, target_ids)
      end

      def decrement_backlog_columns_position(target_ids)
        BacklogColumn.decrement_counter(:position, target_ids)
      end

      def recursive_move_parent_items(item)
        item_parent = item.parent

        until item_parent.nil? || item.backlog_column.parent.nil? do
          item_parent.backlog_column_id = item.backlog_column.parent.id if item_parent.children.all? {|_item_parent_child|
            _item_parent_child.backlog_column.id == item.backlog_column.id
          }
          item_parent.save!

          item = item_parent
          item_parent = item.parent
        end
      end

    end

    def backlog_item_params
      @paramas.require(:backlog_item).permit(:priority, :backlog_column_id)
    end

    def normalize_update_infos(keys, update_infos, *subordinate_infos)
      infos = update_infos.map { |update_info|
        keys.map(&:intern).reduce({}) { |obj, key|
          obj.tap { |me| me[key] = update_info[key] }
        }
      }

      subordinate_infos.keys { |key|
        infos[key] = subordinate_infos[key]
      } unless subordinate_infos.empty?

      return infos
    end
  end
end
