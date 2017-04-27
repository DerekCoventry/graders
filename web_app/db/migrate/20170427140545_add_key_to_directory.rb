class AddKeyToDirectory < ActiveRecord::Migration[5.0]
  def change
    add_column :directories, :key, :string
  end
end
