class RemoveSectionNumberFromCourses < ActiveRecord::Migration[5.0]
  def change
    remove_column :courses, :sectionNumber, :integer
  end
end
