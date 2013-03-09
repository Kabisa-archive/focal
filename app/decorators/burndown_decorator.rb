class BurndownDecorator < Draper::Decorator
  delegate_all

  def to_json
    result = []
    result << ['Day', 'Unstarted', 'Started', 'Finished', 'Delivered', 'Accepted', 'Rejected']
    source.metrics.each do |m|
      result << [m.captured_on.strftime("%a %e"), m.unstarted, m.started, m.finished, m.delivered, m.accepted, m.rejected]
    end

    result.to_json
  end
end
