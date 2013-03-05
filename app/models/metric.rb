class Metric < ActiveRecord::Base

  attr_accessor :token

  # Return the last iteration_id known for a project
  def self.last_iteration_for_project_id(project_id)
    Metric.where(project_id: project_id).maximum(:iteration_id)
  end

  # Create a new metrics snapshot for the given project_id and token.
  def self.create_for_pivotal_project(project_id, token)
    Metric.new do |m|
      m.project_id   = project_id
      m.token        = token
      m.send(:fetch_from_pivotal_tracker)
      m.save
    end
  end

  # Import metrics for all projects
  def self.import_all
    Burndown.pivotal_project_data.each_pair do |project_id, token|
      Metric.create_for_pivotal_project(project_id, token)
    end
  end

  private

  def fetch_from_pivotal_tracker
    PivotalTracker::Client.token = token

    project   = PivotalTracker::Project.find(project_id)
    iteration = project.iteration(:current)
    stories   = iteration.stories

    self.project_id   = project_id
    self.iteration_id = project.current_iteration_number
    self.captured_on  = Time.now.utc.to_date

    self.unstarted = sum_estimates(stories, "unstarted")
    self.started   = sum_estimates(stories, "started")
    self.finished  = sum_estimates(stories, "finished")
    self.delivered = sum_estimates(stories, "delivered")
    self.accepted  = sum_estimates(stories, "accepted")
    self.rejected  = sum_estimates(stories, "rejected")
  end

  def sum_estimates(stories, state)
    stories.inject(0) do |sum, story|
      story.story_type == "feature" && story.current_state == state ? sum + calculate_cp(story) : sum
    end
  end

  # Calculate the actual complexity points of a story. This method handles negative and nil
  # values that the Pivotal Tracker API gives us.
  def calculate_cp(story)
    [story.estimate || 0, 0].max
  end

end
