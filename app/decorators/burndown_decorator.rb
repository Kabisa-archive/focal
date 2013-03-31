class BurndownDecorator < Draper::Decorator
  delegate_all

  def pivotal_tracker_url
    "https://pivotaltracker.com/projects/#{source.pivotal_project_id}"
  end

  def campfire_enabled
    model.campfire_enabled? ? 'Yes' : 'No'
  end
end
