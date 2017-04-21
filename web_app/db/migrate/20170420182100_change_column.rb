class ChangeColumn < ActiveRecord::Migration[5.0]
  def change
  	change_column(:prereqs, :req, :text)
  end
end
