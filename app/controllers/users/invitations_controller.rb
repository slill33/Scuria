class Users::InvitationsController < Devise::InvitationsController
  protect_from_forgery
  before_action :configure_invite_params, only: [:create]
  before_action :configure_accept_invitation_params, only: [:update]

  def new
    super
  end

  def create
    params[:user][:team_id] = current_user.team_id
    params[:user][:super] = 0
    super
    api_session = current_user.api_sessions.create(hash_key: SecureRandom.hex(127), expire_at: Time.now + (60 * 60 * 24))
    cookies[:hash_key] = { value: api_session.hash_key, expires: 24.hour }
  end

  def edit
    super
  end

  def update
    super
  end

  def destroy
    super
  end

  protected

  def configure_invite_params
    devise_parameter_sanitizer.permit(:invite, keys: [:team_id, :name, :super])
  end

  def configure_accept_invitation_params
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:name])
  end
end
