class Iteration < ActiveRecord::Base
  belongs_to :burndown

  has_many :metrics,
    order: "captured_on ASC",
    dependent: :destroy

  def start_on
    start_at.to_date
  end

  def finish_on
    finish_at.to_date
  end
end
