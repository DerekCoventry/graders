class AddRequestsToCourses < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :requestOne, :boolean
    add_column :courses, :requestTwo, :boolean
    add_column :courses, :requestThree, :boolean
    add_column :courses, :requestFour, :boolean
    add_column :courses, :graders, :integer
  end
end
