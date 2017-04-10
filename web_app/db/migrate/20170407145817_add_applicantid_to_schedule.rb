class AddApplicantidToSchedule < ActiveRecord::Migration[5.0]
  def change
    add_column :schedules, :Applicantid, :integer
  end
end
