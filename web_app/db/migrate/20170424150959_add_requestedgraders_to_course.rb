class AddRequestedgradersToCourse < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :requested, :integer
  end
end
