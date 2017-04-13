class AddStudToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :stud, :boolean
  end
end
