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
        message: get_columns_and_association_items
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
      @backlog = Backlog.find_by(hashcode: @params[:hashcode])
    end

    def backlog_contents(id, hashcode)
      Backlog.find_by(hashcode: params[:hashcode])
    end

    concerning :GetMethod do
      def get_columns_and_association_items
        columns_info = @backlog.backlog_columns.map do |column|
          column_info = COLUMN_KEYS.reduce({}) {|obj, key|
            obj.tap {|me| me[key] = column[key] }
          }
          column_info[:items] = get_items_by_column(column)

          column_info
        end

        return {columns: columns_info}
      end

      def get_items_by_column(column)
        items_info = column.backlog_items.map do |item|
          item_info = ITEM_KEYS.reduce({}) {|obj, key|
            obj.tap {|me| me[key] = item[key]}
          }
          item_info[:tags]  = get_tags(item)
          item_info[:users] = get_users(item)

          item_info
        end

        return items_info
      end

      def get_tags(item)
        # TODO: uncomment out 
        #normalize_update_infos(item.backlog_tags, keys)
        return []
      end

      def get_users(item)
        # TODO: uncomment out 
        #normalize_update_infos(item.users, keys)
        return []
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
