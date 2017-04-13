class AddRolesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :admin_role, :boolean, default: false
    add_column :users, :student_role, :boolean, default: false
    add_column :users, :professor_role, :boolean, default: false
  end
end
