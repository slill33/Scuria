module ApplicationHelper
  def current_backlogs
    return Backlog.where(team_id:current_user.team_id)
  end
  def current_backlog_name
    if params[:controller] == "backlogs"
      return Backlog.find_by_id(params[:id]).name
    else
      return current_backlogs.first.name
    end
  end
end
