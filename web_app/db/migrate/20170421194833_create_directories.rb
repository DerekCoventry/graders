class CreateDirectories < ActiveRecord::Migration[5.0]
  def change
    create_table :directories do |t|
      t.string :email
      t.boolean :professor
      t.boolean :staff

      t.timestamps
    end
  end
end
