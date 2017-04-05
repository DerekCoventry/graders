class DropProductsTable < ActiveRecord::Migration[5.0]
  def up
  	drop_table :tests
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
