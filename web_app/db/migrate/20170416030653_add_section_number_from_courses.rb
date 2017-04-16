class AddSectionNumberFromCourses < ActiveRecord::Migration[5.0]
  def change
  	add_column :courses, :sectionNumber, :string
  end
end
