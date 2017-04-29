class ChangeDefaultRequestedCourseValue < ActiveRecord::Migration[5.0]
  def change
  	change_column_default :courses, :requested, 0
  end
end
