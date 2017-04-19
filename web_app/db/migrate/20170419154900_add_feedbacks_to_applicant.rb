class AddFeedbacksToApplicant < ActiveRecord::Migration[5.0]
  def change
    add_column :applicants, :feedback, :integer
  end
end
