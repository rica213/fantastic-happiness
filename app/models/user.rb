class User < ApplicationRecord
  # Associations
  # A user has many posts
  # A user has many comments
  # A user has many likes
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy
  has_many :likes, foreign_key: :author_id, dependent: :destroy

  # Validation
  # Name must not be blank
  validates :name, presence: true

  # PostsCount must be an integer greater than or equal to zero
  validates :posts_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # The 3 most recent posts for a given user
  # @returns {Array<Post>}
  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  # Update the posts counter every time a new post
  # is created for a given user
  after_save :update_posts_count

  # Updates the posts counter for a user
  # @returns {Integer} the number of posts for a given user
  private

  def update_posts_count
    update(posts_count: posts.count)
  end
end
