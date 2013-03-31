class Iteration < ActiveRecord::Base
  belongs_to :burndown

  has_many :metrics,
    order: "captured_on ASC",
    dependent: :destroy

  def start_on
    start_at.to_date
  end

  def finish_on
    finish_at.to_date - 1.day
  end

  def start_at
    read_attribute(:start_at).in_time_zone(burndown.utc_offset)
  end

  def finish_at
    read_attribute(:finish_at).in_time_zone(burndown.utc_offset)
  end
end
