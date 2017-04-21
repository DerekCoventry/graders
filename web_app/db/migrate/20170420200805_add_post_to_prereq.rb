class AddPostToPrereq < ActiveRecord::Migration[5.0]
  def change
    add_column :prereqs, :post, :text
  end
end
