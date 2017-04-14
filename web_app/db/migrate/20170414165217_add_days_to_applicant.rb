class AddDaysToApplicant < ActiveRecord::Migration[5.0]
  def change
    add_column :applicants, :mondayStartFirst, :integer, default: 0
    add_column :applicants, :mondayEndFirst, :integer, default: 0
    add_column :applicants, :tuesdayStartFirst, :integer, default: 0
    add_column :applicants, :tuesdayEndFirst, :integer, default: 0
    add_column :applicants, :wednesdayStartFirst, :integer, default: 0
    add_column :applicants, :wednesdayEndFirst, :integer, default: 0
    add_column :applicants, :thursdayStartFirst, :integer, default: 0
    add_column :applicants, :thursdayEndFirst, :integer, default: 0
    add_column :applicants, :fridayStartFirst, :integer, default: 0
    add_column :applicants, :fridayEndFirst, :integer, default: 0
    add_column :applicants, :mondayStartSecond, :integer, default: 0
    add_column :applicants, :mondayEndSecond, :integer, default: 0
    add_column :applicants, :tuesdayStartSecond, :integer, default: 0
    add_column :applicants, :tuesdayEndSecond, :integer, default: 0
    add_column :applicants, :wednesdayStartSecond, :integer, default: 0
    add_column :applicants, :wednesdayEndSecond, :integer, default: 0
    add_column :applicants, :thursdayStartSecond, :integer, default: 0
    add_column :applicants, :thursdayEndSecond, :integer, default: 0
    add_column :applicants, :fridayStartSecond, :integer, default: 0
    add_column :applicants, :fridayEndSecond, :integer, default: 0
    add_column :applicants, :semester, :string
  end
end
