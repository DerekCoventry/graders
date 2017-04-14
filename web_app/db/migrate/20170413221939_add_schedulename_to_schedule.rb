class AddSchedulenameToSchedule < ActiveRecord::Migration[5.0]
  def change
    add_column :schedules, :schedulename, :string
  end
end
