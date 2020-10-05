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
end
