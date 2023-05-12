class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id

  # The 3 most recent posts for a given user
  # @returns {Array<Post>}
  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  # Updates the posts counter for a user
  # @returns {Integer} the number of posts for a given user
  def update_posts_count
    update(posts_count: posts.count)
  end
end
