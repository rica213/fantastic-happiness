class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  # The 5 most recent comments for a given post
  # @returns {Array<Comment>}
  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  # Updates the comments counter for a post
  # @returns {Integer} the number of comments for a given post
  def update_comments_count
    update(comments_count: comments.count)
  end

  # Updates the likes counter for a post
  # @returns {Integer} the number of likes for a given post
  def update_likes_count
    update(likes_count: likes.count)
  end
end
