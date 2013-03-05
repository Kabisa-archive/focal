class Burndown < ActiveRecord::Base

  # project_ids and token combinations
  def self.pivotal_project_data
    result = {}
    Burndown.find_each do |burndown|
      burndown.pivotal_project_ids.split(",").map { |i| i.scan(/\d+/).first.to_i }.each do |project_id|
        result[project_id] ||= burndown.pivotal_token
      end
    end
    result
  end

  # Return a google charts compatible array of data
  def json_data
    result = []
    result << ['Day', 'Unstarted', 'Started', 'Finished', 'Delivered', 'Accepted', 'Rejected']
    data.each do |d|
      result << [d.captured_on.to_s, d.unstarted, d.started, d.finished, d.delivered, d.accepted, d.rejected]
    end
    result
  end

  # Return data to plot a burndown for the last available iteration
  def data
    # Select proper data for this day.
    select = "captured_on, SUM(unstarted) AS unstarted, SUM(started) AS started, SUM(finished) AS finished, SUM(delivered) AS delivered, SUM(accepted) AS accepted, SUM(rejected) AS rejected"

    conditions = []

    # Gather project_id and iteration data
    pivotal_project_ids.split(",").map { |i| i.scan(/\d+/)[0].to_i }.each do |project_id|
      last_iteration = Metric.last_iteration_for_project_id(project_id)
      next if last_iteration.nil?
      conditions << [project_id, last_iteration]
    end

    # Create conditions dynamically
    values = conditions.flatten
    where  = Array.new(conditions.size, "(project_id = ? AND iteration_id = ?)").join(" OR ")

    # Fetch data, one row per day
    Metric.select(select).where(where, *values).group(:captured_on).order('captured_on ASC').all
  end
end
