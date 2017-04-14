class AddClassesToApplicant < ActiveRecord::Migration[5.0]
  def change
    add_column :applicants, :classOne, :string
    add_column :applicants, :classTwo, :string
    add_column :applicants, :classThree, :string
  end
end
