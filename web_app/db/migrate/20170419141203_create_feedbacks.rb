class CreateFeedbacks < ActiveRecord::Migration[5.0]
  def change
    create_table :feedbacks do |t|
      t.string :professor
      t.string :pemail
      t.integer :courseNumber
      t.string :sectionNumber
      t.string :semail
      t.string :sname
      t.integer :rating
      t.text :notes
      t.references :student, foreign_key: true

      t.timestamps
    end
  end
end
