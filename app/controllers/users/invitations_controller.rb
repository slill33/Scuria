class Users::InvitationsController < Devise::InvitationsController
  before_action :configure_invite_params, only: [:create]
  before_action :configure_accept_invitation_params, only: [:update]
  def new
    super
  end

  def create
    params[:user][:team_id] = current_user.team_id
    params[:user][:super] = 0
    super
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
  def configure_invite_params
    devise_parameter_sanitizer.permit(:invite, keys: [:team_id, :name, :super])
  end
  def configure_accept_invitation_params
    devise_parameter_sanitizer.permit(:accept_invitation, keys: [:team_id, :name])
  end
end

