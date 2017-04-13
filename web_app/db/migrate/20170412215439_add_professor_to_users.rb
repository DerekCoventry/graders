class AddProfessorToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :professor, :boolean, default: false
  end
end
