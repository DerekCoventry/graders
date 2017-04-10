class AddScheduleidToSchedule < ActiveRecord::Migration[5.0]
  def change
    add_column :schedules, :scheduleid, :primarykey
  end
end
