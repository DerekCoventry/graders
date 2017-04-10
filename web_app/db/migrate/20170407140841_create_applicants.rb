class CreateApplicants < ActiveRecord::Migration[5.0]
  def change
    create_table :applicants do |t|
      t.string :fname
      t.string :lname
      t.integer :year
      t.string :email
      t.boolean :available

      t.timestamps
    end
  end
end
