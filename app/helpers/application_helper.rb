module ApplicationHelper
  def current_backlogs
    return Backlog.where(team_id: current_user.team_id)
  end

  def current_backlog_name
    if params[:controller] == "backlogs" && params[:action] == "show"
      return Backlog.find_by_id(params[:id]).name
    elsif current_backlogs.length > 0
      return current_backlogs.first.name
    else
      return ""
    end
  end
end
