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
  end

  def create
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
end
