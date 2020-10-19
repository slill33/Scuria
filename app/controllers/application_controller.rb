class ApplicationController < ActionController::Base
  add_flash_types :success, :info, :warning, :danger

  def after_sign_out_path_for(resource)
    new_user_session_path
  end
end
