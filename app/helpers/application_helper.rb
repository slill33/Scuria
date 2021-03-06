module ApplicationHelper
  def display_header_backlogs
    return Backlog.where(id: UserToBacklog.where(user_id: current_user.id).pluck(:backlog_id))
  end

  def current_team
    return Team.find_by_id(current_user.team_id)
  end

  def current_backlog_name
    if params[:controller] == "backlogs" && params[:action] == "show"
      return Backlog.find_by_id(params[:id]).name
    elsif current_team.backlogs.length > 0
      return current_team.backlogs.first.name
    else
      return ""
    end
  end
end
