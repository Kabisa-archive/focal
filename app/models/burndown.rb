class Burndown < ActiveRecord::Base

  attr_accessible :name, :pivotal_token, :pivotal_project_id

  has_many :iterations,
    order: "number DESC",
    dependent: :destroy

  has_many :metrics,
    order: "metrics.captured_on ASC",
    through: :iterations

  def previous_iterations
    # Drop the first iteration, the current iteration
    iterations[1..-1]
  end

  # Import metrics for all projects
  def self.import_all
    Burndown.find_each { |burndown| burndown.import }
  end

  def import
    Metric.create do |metric|
      metric.iteration   = create_or_update_iteration
      metric.captured_on = Time.now.utc.to_date

      %w(unstarted started finished delivered accepted rejected).each do |state|
        metric.send("#{state}=", pivotal_iteration.send("#{state}"))
      end
    end
  end

  # Returns the current iteration
  def current_iteration
    iterations.first
  end

  private
  def create_or_update_iteration
    iterations.find_or_create_by_number(pivotal_iteration.number) do |iteration|
      iteration.pivotal_iteration_id = pivotal_iteration.pivotal_id
      iteration.start_at             = pivotal_iteration.start_at
      iteration.finish_at            = pivotal_iteration.finish_at
    end
  end

  def pivotal_iteration
    @pivotal_iteration ||= PivotalIteration.new(pivotal_token, pivotal_project_id)
  end
end
