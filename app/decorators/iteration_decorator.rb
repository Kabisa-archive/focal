class IterationDecorator < Draper::Decorator
  delegate_all

  def start_on
    source.start_on.strftime("%F")
  end

  def finish_on
    source.finish_on.strftime("%F")
  end

  def to_json
    result = []

    # Attach the header
    result << ['Day', 'Unstarted', 'Started', 'Finished', 'Delivered', 'Accepted', 'Rejected']

    # Loop over each day in the iteration and use any recorded
    # metrics if available.
    source.start_on.step(source.finish_on).each_with_index do |day, i|
      m = source.metrics.fetch(i, nil)

      result << [
        day.strftime("%a %e"),
        m.present? ? m.unstarted : 0,
        m.present? ? m.started   : 0,
        m.present? ? m.finished  : 0,
        m.present? ? m.delivered : 0,
        m.present? ? m.accepted  : 0,
        m.present? ? m.rejected  : 0,
      ]
    end

    result.to_json
  end
end

