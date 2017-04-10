class AddAppidToApplicant < ActiveRecord::Migration[5.0]
  def change
    add_column :applicants, :appid, :primarykey
  end
end
