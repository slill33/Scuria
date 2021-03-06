module PrivateApi
  class BacklogItemsController < ApiController
    before_action :parse_request_body, only: [:create, :update, :destroy]
    before_action :find_backlog_item, only: [:update, :destroy]
    before_action :check_session
    before_action :check_role, only: [:create, :destroy]
    skip_before_action :verify_authenticity_token

    #{
    #  backlog_column_id: 1,
    #  name: 'sample backlog item',
    #  point: 33,
    #  description: 'sample description',
    #  user_ids: [1, 2, 3],
    #  tag_ids: [3, 4, 8]
    #}
    def create
      @backlog_column_id = @params[:backlog_column_id]
      @name = @params[:name],
      @description = @params[:description]
      @point = @params[:point],
      @user_ids = @params[:user_ids]
      @tag_ids = @params[:tag_ids]
      @child_backlog_id = @params[:child_backlog_id]

      @bc = BacklogColumn.find_by_id(@backlog_column_id)

      @bi = @bc.backlog_items.build(
        name: @params[:name],
        point: @params[:point],
        description: @params[:description],
        parent_id: @params[:parent_id],
        priority: new_priority,
        backlog_id: @bc.backlog_id,
      )

      if @bi.valid?
        @bi.save!
        set_users_to_backlog_item
        set_tags_to_backlog_item

        render json: { created_item_id: @bi.id }.to_json, status: 200
      else
        render json: "internal server error", status: :internal_server_error
      end
    end

    def update
      @bi.name = @params[:name]
      @bi.point = @params[:point]
      @bi.description = @params[:description]
      @bi.child_backlog_id = @params[:child_backlog_id]
      @bi.parent_id = @params[:parent_id]
      @user_ids = @params[:user_ids]
      @tag_ids = @params[:tag_ids]

      if @bi.valid?
        @bi.save!
        set_users_to_backlog_item
        set_tags_to_backlog_item

        render json: {}, status: 200
      else
        render json: "internal server error", status: :internal_server_error
      end
    end

    def destroy
      if @bi.destroy
        shift_target_bi_ids = BacklogItem.shift_targets_when_destroy(@bi.backlog_column_id, @bi.priority).pluck(:id)
        BacklogItem.decrement_counter(:priority, shift_target_bi_ids) unless shift_target_bi_ids.empty?

        render json: {}, status: 200
      else
        render json: "internal server error", status: :internal_server_error
      end
    end

    private

    def max_priority
      return @bc.backlog_items.pluck(:priority).max || -1
    end

    def new_priority
      return max_priority + 1
    end

    def set_users_to_backlog_item
      UserToBacklogItem.where(backlog_item_id: @bi.id).destroy_all
      @user_ids.each { |user_id|
        UserToBacklogItem.create!(user_id: user_id, backlog_item_id: @bi.id, backlog_id: params[:id])
      }
    end

    def set_tags_to_backlog_item
      BacklogItemToBacklogTag.where(backlog_item_id: @bi.id).destroy_all
      @tag_ids.each { |tag_id|
        BacklogItemToBacklogTag.create!(backlog_tag_id: tag_id, backlog_item_id: @bi.id)
      }
    end

    def find_backlog_item
      @bi = BacklogItem.find_by_id(@params[:id])
    end

    #{
    #  id: 1,
    #  backlog_id: 1,
    #  backlog_column_id: 4,
    #  name: 'sample backlog item',
    #  point: 33,
    #  description: 'sample description',
    #  parent_id: 3,
    #  user_ids: [1, 2, 3],
    #  tag_ids: [3, 4, 8],
    #  priority: 3
    #}
  end
end
