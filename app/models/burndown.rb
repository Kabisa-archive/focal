class Burndown < ActiveRecord::Base

  attr_accessible :name, :pivotal_token, :pivotal_project_id,
    :campfire_subdomain, :campfire_token, :campfire_room_id

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

  def campfire_enabled?
    [campfire_subdomain, campfire_token, campfire_room_id].all?(&:present?)
  end

  # Import metrics for all projects
  def self.import_all
    Burndown.find_each do |burndown|
      begin
        burndown.import
      rescue => e
        log.error("Error importing data: " + e)
      end
    end
  end

  def import
    update_burndown_utc_offset

    metric_iteration = create_or_update_iteration
    metric_captured_on = Time.now.utc.to_date

    metric = Metric.where(iteration_id: metric_iteration.id, captured_on: metric_captured_on).first ||
      Metric.new.tap { |m|
        m.iteration = metric_iteration
        m.captured_on = metric_captured_on
      }

    %w(unstarted started finished delivered accepted rejected).each do |state|
      metric.send("#{state}=", pivotal_iteration.send("#{state}"))
    end

    metric.save

    notify_campfire if campfire_enabled?
  end

  def force_update
    import
  end

  # Returns the current iteration
  def current_iteration
    iterations.first
  end

  private

  def notify_campfire
    message = "A new burndown is available at http://#{Settings.site_url}/burndowns/#{id}"

    campfire = Tinder::Campfire.new campfire_subdomain, token: campfire_token
    room = campfire.find_room_by_id(campfire_room_id)
    room.speak message
  end

  def update_burndown_utc_offset
    update_attribute(:utc_offset, pivotal_iteration.utc_offset)
  end

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
