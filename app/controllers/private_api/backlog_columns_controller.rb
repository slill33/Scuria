module PrivateApi
  class BacklogColumnsController < ApplicationController

    before_action :parse_request_body,  only: [:create, :update, :destroy]
    before_action :find_backlog_column, only: [:update, :destroy]

    skip_before_action :verify_authenticity_token

    #{
    #  backlog_id: 1,
    #  name: 'first column',
    #  color: '#000000'
    #}
    def create
      @bc = BacklogColumn.new(
        backlog_id: @params[:backlog_id],
        name:       @params[:name],
        color:      @params[:color],
        position:   new_position
      )

      if @bc.valid?
        @bc.save!
        render json: { created_column_id: @bc.id }.to_json, status: 200
      else
        render json: "internal server error", status: :internal_server_error
      end
    end

    def update
      @bc.name  = @params[:name]
      @bc.color = @params[:color]

      if @bc.valid?
        @bc.save!
        render json: {}, status: 200
      else
        render json: "internal server error", status: :internal_server_error
      end
    end

    def destroy
      if @bc.destroy
        shift_target_bc_ids = BacklogColumn.shift_targets_when_destroy(@bc.backlog_id, @bc.position).pluck(:id)
        BacklogColumn.decrement_counter(:position, shift_target_bc_ids) unless shift_target_bc_ids.empty?

        render json: {}, status: 200
      else
        render json: "internal server error", status: :internal_server_error
      end
    end

    private

    def end_of_position
      return BacklogColumn.where(backlog_id: @params[:backlog_id]).pluck(:position).max || -1
    end

    def new_position
      return end_of_position + 1
    end

    def find_backlog_column
      @bc = BacklogColumn.find_by_id(@params[:id])
    end

    #{
    #  id: 1,
    #  backlog_id: 2,
    #  name:  'first column',
    #  color: '#000000'
    #  position: 3
    #}
    def parse_request_body
      body = request.body.read
      @params ||= JSON.parse(body, symbolize_names: true)
    end

  end
end
