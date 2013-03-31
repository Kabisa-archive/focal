class AddCampfireFieldsToBurndowns < ActiveRecord::Migration
  def change
    add_column :burndowns, :campfire_subdomain, :string
    add_column :burndowns, :campfire_token, :string
    add_column :burndowns, :campfire_room_id, :string
  end
end
