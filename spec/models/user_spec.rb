require 'rails_helper'

RSpec.describe User, type: :model do
  before :all do
    @user = User.create(name: 'Rasoa Kely', photo: 'https://unsplash.com/photos/RGKdWJOUFH0',
                        bio: 'Rasoa Kely rocks!')
  end
  describe 'validations' do
    it 'should validate the presence of name' do
      @user.name = nil
      expect(@user).to_not be_valid
    end

    it 'should validate numericality of posts_count' do
      @user.posts_count = 'hello'
      expect(@user).to_not be_valid
    end

    it 'should validate the sign of the posts_count' do
      @user.posts_count = -5
      expect(@user).to_not be_valid
    end
  end

  describe 'associations' do
    it 'should have many posts' do
      expect(@user.posts).to eq([])
    end

    it 'should have many comments' do
      expect(@user.comments).to eq([])
    end

    it 'should have many likes' do
      expect(@user.likes).to eq([])
    end
  end

  describe 'recent posts by user' do
    it 'should return the 3 most recent posts' do
      5.times do |i|
        Post.create(author: @user, title: "Post #{i}", text: "Post #{i} body")
      end
      expect(@user.recent_posts).to eq(@user.posts.order(created_at: :desc).limit(3))
    end
  end
end
