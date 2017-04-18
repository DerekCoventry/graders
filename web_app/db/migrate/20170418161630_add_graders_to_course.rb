class AddGradersToCourse < ActiveRecord::Migration[5.0]
  def change
    add_column :courses, :graderOne, :string
    add_column :courses, :graderTwo, :string
    add_column :courses, :graderThree, :string
    add_column :courses, :graderFour, :string
  end
end
