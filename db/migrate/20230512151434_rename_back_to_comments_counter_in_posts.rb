class RenameBackToCommentsCounterInPosts < ActiveRecord::Migration[7.0]
  def change
    rename_column :posts, :comments_count, :comments_counter
  end
end
