class Post < ApplicationRecord
  # Associations
  # A post belongs to an author
  # A post has many comments
  # A post has many likes
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  # Validation
  # Title must not be blank
  validates :title, presence: true

  # Title must not exceed 250 characters
  validates :title, length: { maximum: 250 }

  # CommentsCounter must be an integer greater than or equal to zero
  validates :comments_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # LikesCounter must be an integer greater than or equal to zero
  validates :likes_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # The 5 most recent comments for a given post
  # @returns {Array<Comment>}
  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  # Use of active record callback
  # Update the comments counter every time a new comment
  # is created for a given post
  after_save :update_comments_count

  # Update the likes counter every time a new like
  # is created for a given post
  after_save :update_likes_count

  private

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
