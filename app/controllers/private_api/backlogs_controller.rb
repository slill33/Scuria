module PrivateApi
  class BacklogsController < ApplicationController
    COLUMN_KEYS = %i(id name color)
    ITEM_KEYS   = %i(id name point)
    TAG_KEYS    = %i(id name)
    USER_KEYS   = %i(id name)

    skip_before_action :verify_authenticity_token

    before_action :parse_request_body, only: [:upsert]
    before_action :find_backlog


    def get_columns_and_items
      render json: {
        status:  200,
        message: {
          columns: get_columns_and_association_items,
          tags: get_normalize_tag_records,
          users: get_normalize_user_records
        },
      }.to_json
    rescue
      render json: "internal server error", status: :internal_server_error
    end


    def update_item_location
      update_target_item = BacklogItem.find_by_id(@params[:backlog_item_id])
      new_column_id      = @params[:new_column_id]
      new_priority       = @params[:new_priority]
      old_column_id      = update_target_item.column_id
      old_priority       = update_target_item.priority

      old_column_items = BacklogColumn.find_by_id(old_column_id).backlog_items
      priority_max = old_column_items.maximum(:priority)
      old_column_items.where(priority: new_priority..priority_max).order(priority: "DESC")

      # カラムをまたいだ変更があった場合インクリメント
      old_column_item_ids = old_column_items.where(priority: new_priority..priority_max).pluck(:id)
      BacklogItem.icrement_counter(:priority, item_ids)

      if old_column_id == new_column_id then
        # カラムをまたいだ変更がなかった場合
        ## priority:1以上 が移動した場合インクリメント
        if new_priority > old_priority then
          old_column_item_ids = old_column_items.where(priority: (old_priority+1)..new_priority).pluck(:id)
          BacklogItem.decrement_counter(:priority, old_column_item_ids)
        elsif old_priority > new_priority then
          old_column_item_ids = old_column_items.where(priority: new_priority..(old_priority-1)).pluck(:id)
          BacklogItem.increment_counter(:priority, old_column_item_ids)
        end
      else
        new_column_items = BacklogColumn.find_by_id(new_column_id).backlog_items

        old_column_item_ids = old_column_items.where(priority: (old_priority+1)..old_column_items.maximum(:priority))
        new_column_item_ids = new_column_items.where(priority: new_priority..new_column_items.maximum(:priority))

        BacklogItem.decrement_counter(:priority, old_column_item_ids)
        BacklogItem.increment_counter(:priority, new_column_item_ids)
      end

      # TODO: after_update other backlog_item
      update_target_item.update(backlog_column_id: new_column_id, priority: new_priority)

      render json: {
        status: 200,
        message: "ok"
      }.to_json
    rescue
      render json: "internal server error", status: :internal_server_error
    end

    def update_item_info
      # update_target_attributes: {
      #   backlog_item_id: 1
      #   name:            test
      #   point:           3
      #   priority:        1
      # }
      update_target_attributes = @params[:update_target_attributes]
      update_target_item       = BacklogItem.find_by_id(@params[:backlog_item_id])
      update_target_item.update(update_target_attributes)

      render json: {
        status: 200,
        message: "ok"
      }.to_json
    rescue
      render json: "internal server error", status: :internal_server_error
    end

    private

    def parse_request_body
      @params ||= JSON.parse(request.body.read, { symbolize_names: true })
    end

    def find_backlog
      # 暫定でhashcodeにしました。
      # 適当にいじってくれれば
      @backlog = Backlog.find_by(id: params[:id].to_i)
    end

    def backlog_contents(id, hashcode)
      Backlog.find_by(hashcode: params[:hashcode])
    end

    concerning :GetMethod do

      def get_columns_and_association_items
        get_normalize_info(@backlog.backlog_columns, COLUMN_KEYS, %i(items))
      end

      def get_items_by_column(column)
        get_normalize_info(column.backlog_items, ITEM_KEYS, %i(tags users))
      end

      def get_normalize_info(obj_arrays, keys, additional_obj_keys)
        info = obj_arrays.map do |obj|
          info = keys.reduce({}) {|memo, key|
            memo.tap {|me| me[key] = obj[key] }
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
        when :tags  then
          BacklogTag.where(backlog_id: @backlog.id).pluck(:id)
        when :users then
          Team.find_by_id(@backlog.team_id).users.pluck(:id)
        when :items then
          get_items_by_column(obj)
        else
          []
        end
      end


      %w(BacklogTag User).each do |model_name|
        define_method("get_normalize_#{model_name.underscore}_records") do |root_key: :id, attr_names: %i(name)|
          normalize_obj_records_by_backlog_id(root_key, attr_names, model_name)
        end
      end

      def normalize_obj_records_by_backlog_id(root_key, attr_names, model_name)
        objs = model_name.constantize.where(backlog_id: @backlog.id).pluck(root_key, *attr_names)

        return objs.reduce({}) {|memo, obj|
          h = {}
          attr_names.each.with_index(1) {|attr_name, idx| h["#{attr_name}".intern] = obj[idx] }

          memo.tap {|me| me["#{obj.first}".intern] = h }
        }
      end
    end

    concerning :UpdateMethod do
      #def update_backlog_items_priority(old_column_id, new_column_id, priority)
      #end
    end

    def backlog_item_params
      @paramas.require(:backlog_item).permit(:priority, :backlog_column_id)
    end

    def normalize_update_infos(keys, update_infos, *subordinate_infos)
      infos = update_infos.map {|update_info|
        keys.map(&:intern).reduce({}) {|obj, key|
          obj.tap {|me| me[key] = update_info[key]}
        }
      }

      subordinate_infos.keys {|key|
        infos[key] = subordinate_infos[key]
      } unless subordinate_infos.empty?

      return infos
    end

  end
end
