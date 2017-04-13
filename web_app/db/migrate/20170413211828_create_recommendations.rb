class CreateRecommendations < ActiveRecord::Migration[5.0]
  def change
    create_table :recommendations do |t|
      t.string :professor
      t.string :pemail
      t.string :student
      t.string :semail
      t.string :course
      t.text :notes

      t.timestamps
    end
  end
end
