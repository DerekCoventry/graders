class CreateCourses < ActiveRecord::Migration[5.0]
  def change
    create_table :courses do |t|
      t.integer :sectionNumber, :primarykey
      t.integer :courseNumber
      t.integer :mondayStart
      t.integer :mondayEnd
      t.integer :tuesdayStart
      t.integer :tuesdayEnd
      t.integer :wednesdayStart
      t.integer :wednesdayEnd
      t.integer :thursdayStart
      t.integer :thursdayEnd
      t.integer :fridayStart
      t.integer :fridayEnd
      t.string :professor

      t.timestamps
    end
  end
end
