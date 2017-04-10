class AddScheduleToApplicant < ActiveRecord::Migration[5.0]
  def change
    add_reference :applicants, :schedule, foreign_key: true
  end
end
