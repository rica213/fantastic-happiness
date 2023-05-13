class RenameCounter < ActiveRecord::Migration[7.0]
  def change
    rename_column :posts, :likes_counter, :likes_count
    rename_column :posts, :comments_counter, :comments_count
  end
end
