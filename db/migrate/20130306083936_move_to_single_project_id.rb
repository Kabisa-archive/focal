class MoveToSingleProjectId < ActiveRecord::Migration
  def change
    remove_column :burndowns, :pivotal_project_ids
    add_column :burndowns, :pivotal_project_id, :integer
  end
end
