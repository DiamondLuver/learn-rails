class DropRoleFromUserTable < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :role
  end
end
