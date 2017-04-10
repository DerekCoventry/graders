class CreateSchedules < ActiveRecord::Migration[5.0]
  def change
    create_table :schedules do |t|
      t.decimal :mondayStart
      t.decimal :mondayEnd
      t.decimal :tuesdayStart
      t.decimal :tuesdayEnd
      t.decimal :wednesdayStart
      t.decimal :wednesdayEnd
      t.decimal :thursdayStart
      t.decimal :thursdayEnd
      t.decimal :fridayStart
      t.decimal :fridayEnd

      t.timestamps
    end
  end
end
