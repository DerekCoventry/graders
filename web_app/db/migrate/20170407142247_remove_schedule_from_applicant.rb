class RemoveScheduleFromApplicant < ActiveRecord::Migration[5.0]
  def change
    remove_reference :applicants, :schedule, foreign_key: true
  end
end
