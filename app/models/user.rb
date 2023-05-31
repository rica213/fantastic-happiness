class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
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
end
