class AddStudentToApplicant < ActiveRecord::Migration[5.0]
  def change
    add_reference :applicants, :student, foreign_key: true
  end
end
