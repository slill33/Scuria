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
  end

  def create
    backlog_info = backlog_params
    if backlog_info[:parent_id] != nil
      backlog = Backlog.new(name: backlog_info[:name], parent_id: backlog_info[:parent_id], team_id: current_user[:team_id], backlog_type_id: 1)
    else
      backlog = Backlog.new(name: backlog_info[:name], team_id: current_user[:team_id], backlog_type_id: 1)
    end

    backlog.save

    redirect_to backlogs_path, turbolinks: false
  end

  def show
  end

  def edit
  end

  def update
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
