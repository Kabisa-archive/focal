class Burndown < ActiveRecord::Base

  # Return a google charts compatible array of data
  def json_data
    result = []
    result << ['Day', 'Unstarted', 'Started', 'Finished', 'Delivered', 'Accepted', 'Rejected']
    data.each do |d|
      result << [d.captured_on.strftime("%a %e"), d.unstarted, d.started, d.finished, d.delivered, d.accepted, d.rejected]
    end
    result
  end

  # Return data to plot a burndown for the last available iteration
  def data
    # Gather project_id and iteration data
    last_iteration = Metric.last_iteration_for_project_id(pivotal_project_id)
    return [] if last_iteration.nil?

    # Fetch data, one row per day
    select = "captured_on, SUM(unstarted) AS unstarted, SUM(started) AS started, SUM(finished) AS finished, SUM(delivered) AS delivered, SUM(accepted) AS accepted, SUM(rejected) AS rejected"
    Metric.select(select)
      .where(["project_id = ? AND iteration_id = ?", pivotal_project_id, last_iteration])
      .group(:captured_on)
      .order('captured_on ASC')
      .all
  end
end
