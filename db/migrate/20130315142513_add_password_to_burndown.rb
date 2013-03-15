class AddPasswordToBurndown < ActiveRecord::Migration
  def change
    add_column :burndowns, :password_digest, :string, default: nil
  end
end
