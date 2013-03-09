class Iteration < ActiveRecord::Base
  belongs_to :burndown

  has_many :metrics,
    order: "captured_on ASC",
    dependent: :destroy
end