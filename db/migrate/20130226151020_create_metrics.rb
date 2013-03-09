class CreateMetrics < ActiveRecord::Migration
  def change
    create_table :metrics do |t|
      t.integer  :iteration_id, null: false

      t.date     :captured_on

      # Actual metrics
      t.integer :unstarted, default: 0
      t.integer :started,   default: 0
      t.integer :finished,  default: 0
      t.integer :delivered, default: 0
      t.integer :accepted,  default: 0
      t.integer :rejected,  default: 0

      t.timestamps
    end

    add_index :metrics, :iteration_id
  end
end
