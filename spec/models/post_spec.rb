require 'rails_helper'

RSpec.describe Post, type: :model do
  before :all do
    @user = User.create(name: 'Someone', photo: '', bio: 'Yet another human.')
    @user.save
    @post = Post.create(author: @user, title: 'Hello world', text: 'Hello world body')
  end

  describe 'validation' do
    it 'should validate the presence of the title' do
      @post.title = nil
      expect(@post).to_not be_valid
    end

    it 'should validate the length of the title to be less than 250 characters' do
      @post.title = 'a' * 251
      expect(@post).to_not be_valid
    end

    it 'should validate the numericality of the comments_count' do
      @post.comments_count = 'hello'
      expect(@post).to_not be_valid
    end

    it 'comments_count should be a positive number' do
      @post.comments_count = -5
      expect(@post).to_not be_valid
    end

    it 'should validate the numericality of the likes_count' do
      @post.likes_count = 'hello'
      expect(@post).to_not be_valid
    end

    it 'likes_count should be a positive number' do
      @post.likes_count = -5
      expect(@post).to_not be_valid
    end
  end

  describe 'Associations' do
    it 'should have many comments' do
      expect(@post.comments).to eq([])
    end

    it 'should have many likes' do
      expect(@post.likes).to eq([])
    end

    it 'should belong to an author' do
      expect(@post.author).to eq(@user)
    end
  end
end
