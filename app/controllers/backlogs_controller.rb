class BacklogsController < ApplicationController
  before_action :authenticate_user!

  def index
    backlogs = Backlog.where(team_id: current_user[:team_id])
    @affiliated_backlogs = backlogs.reduce([]) { |array, backlog|
      if backlog.users.pluck(:id).include?(current_user.id)
        array.push(backlog)
      else
        array
      end
    }
    if current_user.super?
      @backlogs = backlogs
    end
  end

  def new
    @backlog = Backlog.new
    @user_and_role_ids = "[]"
  end

  def create
    backlog_info = backlog_params
    if backlog_info[:parent_id] != nil
      backlog = Backlog.create(name: backlog_info[:name], parent_id: backlog_info[:parent_id], team_id: current_user[:team_id], backlog_type_id: 1)
    else
      backlog = Backlog.create(name: backlog_info[:name], team_id: current_user[:team_id], backlog_type_id: 1)
    end
    JSON.parse(params[:user_and_role_ids], symbolize_names: true).each do |hash|
      UserToBacklog.create(user_id: hash[:user_id], backlog_id: backlog.id, team_role_id: hash[:role_id])
    end

    redirect_to backlogs_path, turbolinks: false
  end

  def show
  end

  def edit
    @backlog = Backlog.find_by_id(params[:id])
    @user_and_role_ids = JSON.generate(
      UserToBacklog.where(backlog_id: params[:id]).map { |utb| { user_id: utb.user_id, role_id: utb.team_role_id } }
    )
  end

  def update
    backlog_info = backlog_params
    backlog = Backlog.find_by_id(params[:id])
    if backlog_info[:parent_id] != nil
      backlog.update_attributes(name: backlog_info[:name], parent_id: backlog_info[:parent_id], team_id: current_user[:team_id], backlog_type_id: 1)
    else
      backlog.update_attributes(name: backlog_info[:name], team_id: current_user[:team_id], backlog_type_id: 1)
    end
    left_user = JSON.parse(params[:user_and_role_ids], symbolize_names: true).pluck(:user_id) & backlog.user_to_backlogs.pluck(:user_id)
    remove_user = backlog.user_to_backlogs.pluck(:user_id) - left_user
    UserToBacklogItem.where(user_id: backlog.user_to_backlogs.pluck(:user_id) - left_user).where(backlog_id: backlog.id).destroy_all

    UserToBacklog.where(backlog_id: backlog.id).destroy_all
    JSON.parse(params[:user_and_role_ids], symbolize_names: true).each do |hash|
      UserToBacklog.create(user_id: hash[:user_id], backlog_id: backlog.id, team_role_id: hash[:role_id])
    end

    redirect_to backlogs_path, turbolinks: false
  end

  def destroy
    Backlog.find(params[:id]).destroy
    redirect_to action: :index
  end

  private

  def get_backlog_role(user, backlog_id)
    TeamRole.find_by_id(user.user_to_backlogs.where(backlog_id: backlog_id)[0].team_role_id)
  end

  def backlog_params
    params.require(:backlog).permit(:name, :backlog_type_id, :parent_id, :users)
  end
end
