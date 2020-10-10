module PrivateApi
  class BacklogItemsController < ApplicationController

    before_action :parse_request_body, only: [:create, :update, :destroy]
    before_action :find_backlog_item,  only: [:update, :destroy]

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
      @name              = @params[:name],
      @point             = @params[:point],
      @description       = @params[:description]
      @user_ids          = @params[:user_ids]
      @tag_ids           = @params[:tag_ids]

      @bc = BacklogColumn.find_by_id(@backlog_column_id)

      @bi = @bc.backlog_items.build(
        name:        @params[:name],
        point:       @params[:point],
        description: @params[:description],
        priority:    new_priority
      )

      if @bi.valid?
        @bi.save!
        set_users_to_backlog_item
        set_tags_to_backlog_item

        render json: {}, status: 200
      else
        render json: "internal server error", status: :internal_server_error
      end
    end

    def update
      @bi.name        = @params[:name],
      @bi.point       = @params[:point],
      @bi.description = @params[:description],
      @user_ids       = @params[:user_ids]
      @tag_ids        = @params[:tag_ids]

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
        render json: {}, status: 200
      else
        render json: "internal server error", status: :internal_server_error
      end
    end

    private

    def max_priority
      @bc.backlog_items.pluck(:id).max
    end

    def new_priority
      max_priority + 1
    end

    def set_users_to_backlog_item
      UserToBacklogItem.where(backlog_item_id: @bi.id).destroy_all
      @user_ids.each {|user_id|
        UserToBacklogItem.create!(user_id: user_id, backlog_item_id: @bi.id)
      }
    end

    def set_tags_to_backlog_item
      BacklogItemToBacklogTag.where(backlog_item_id: @bi.id).destroy_all
      @tag_ids.each {|tag_id|
        BacklogItemToBacklogTag.create!(backlog_tag_id: tag_id, backlog_item_id: @bi.id)
      }
    end

    def find_backlog_item
      @bi = BacklogItem.find_by_id(@params[:id])
    end

    #{
    #  id: 1,
    #  name: 'sample backlog item',
    #  point: 33,
    #  description: 'sample description',
    #  user_ids: [1, 2, 3],
    #  tag_ids: [3, 4, 8]
    #}
    def parse_request_body
      @params ||= JSON.parse(request.body.read, { symbolize_names: true })
    end

  end
end
