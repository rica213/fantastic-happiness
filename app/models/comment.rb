class Comment < ApplicationRecord
  # Associations
  # A comment belongs to an author
  # A comment belongs to a post
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  belongs_to :post, foreign_key: :post_id

  # Use of active record callback
  # Update the comments counter every time a new comment
  # is created for a given post
  after_save :update_comments_count

  private

  # Updates the comments counter for a post
  # @returns {Integer} the number of comments for a given post
  def update_comments_count
    post.increment!(:comments_count)
  end
end
