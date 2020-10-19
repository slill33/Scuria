module PrivateApi
  class ApiController < ApplicationController
    def check_session
      api_session = ApiSession.find_by_hash_key(cookies[:hash_key])
      current_user = User.find_by_id(api_session.user_id)

      if api_session == nil || api_session.expire_at < Time.now || (UserToBacklog.where(user_id: current_user.id).pluck(:backlog_id).include?(params[:id].to_i) == false && current_user.super == false)
        render json: { message: "セッションが正しくありません" }, status: 401
      end
    end

    def check_role
      api_session = ApiSession.find_by_hash_key(cookies[:hash_key])
      current_user = User.find_by_id(api_session.user_id)
      role = TeamRole.find_by_id(UserToBacklog.where(user_id: current_user.id, backlog_id: params[:id]).first.team_role_id).name
      ##if role != "ScrumMaster" && role !="ProductOwner"
      if role == "Member"
        render json: { message: "Memberには許可されていません" }, status: 403
      end
    end

    def parse_request_body
      body = request.body.read
      @params ||= JSON.parse(body, symbolize_names: true)
    end
  end
end
