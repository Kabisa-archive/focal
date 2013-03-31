class AddUtcOffsetToBurndowns < ActiveRecord::Migration
  def change
    add_column :burndowns, :utc_offset, :integer, default: 0
  end
end
