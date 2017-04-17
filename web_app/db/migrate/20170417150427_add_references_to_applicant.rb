class AddReferencesToApplicant < ActiveRecord::Migration[5.0]
  def change
    add_column :applicants, :references, :integer
  end
end
