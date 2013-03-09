class CreateBurndowns < ActiveRecord::Migration
  def change
    create_table :burndowns do |t|
      t.string :name

      t.string :pivotal_token,       limit: 40, null: false
      t.string :pivotal_project_id,             null: false

      t.timestamps
    end
  end
end
