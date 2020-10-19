module PrivateApi
  class BacklogTagsController < ApiController
    before_action :parse_request_body, only: [:create]
    before_action :check_session
    before_action :check_role, only: [:create]
    skip_before_action :verify_authenticity_token

    def create
      tag = BacklogTag.create(name: @params[:name], backlog_id: params[:id])
      render json: { created_tag_id: tag.id }.to_json, status: 200
    end

    private
  end
end
