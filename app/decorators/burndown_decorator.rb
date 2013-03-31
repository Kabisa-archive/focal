class BurndownDecorator < Draper::Decorator
  delegate_all

  def pivotal_tracker_url
    "https://pivotaltracker.com/projects/#{source.pivotal_project_id}"
  end
end
