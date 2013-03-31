class PivotalIteration
  attr_accessor :token, :project_id

  def initialize(token, project_id)
    @token, @project_id = token, project_id
    PivotalTracker::Client.token = token
  end

  def number
    current_iteration.number
  end

  def pivotal_id
    current_iteration.id
  end

  def start_at
    current_iteration.start
  end

  def finish_at
    current_iteration.finish
  end

  def utc_offset
    project.first_iteration_start_time.utc_offset
  end

  %w(unstarted started finished delivered accepted rejected).each do |state|
    define_method state do
      sum(state)
    end
  end

  private
  def sum(*states)
    current_stories.inject(0) do |sum, story|
      states.include?(story.current_state) ? sum + calculate_cp(story) : sum
    end
  end

  def calculate_cp(story)
    [story.estimate || 0, 0].max
  end

  def current_stories
    current_iteration.stories
  end

  def current_iteration
    @current_iteration ||= project.iteration(:current)
  end

  def project
    @project ||= PivotalTracker::Project.find(project_id)
  end
end
