class CreatePrereqs < ActiveRecord::Migration[5.0]
  def change
    create_table :prereqs do |t|
      t.integer :courseNumber
      t.integer :req

      t.timestamps
    end
  end
end
