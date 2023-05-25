class Like < ApplicationRecord
  # Associations
  # A like belongs to an author
  # A like belongs to a post
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  belongs_to :post, foreign_key: :post_id

  # Update the likes counter every time a new like
  # is created for a given post
  after_save :update_likes_count

  private
  
  # Updates the likes counter for a post
  # @returns {Integer} the number of likes for a given post
  def update_likes_count
    post.increment!(:likes_count)
  end
end
