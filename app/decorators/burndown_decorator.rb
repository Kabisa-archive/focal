class BurndownDecorator < Draper::Decorator
  delegate_all

  def pivotal_tracker_url
    "https://pivotaltracker.com/projects/#{source.pivotal_project_id}"
  end

  def session_identifier
    "session_burndown_#{source.id}"
  end
end
