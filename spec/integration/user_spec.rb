require 'rails_helper'

RSpec.describe 'User View', type: :feature do
  before :each do
    # create a user to use in our tests
    @user = User.create(name: 'Bunny', photo: 'https://somewhere.com/an_ordinary_photo.jpg',
                        bio: 'Anyone in this world')
    @user.save
  end
  # checks if the user's profile picture can be seen
  it 'should render the profile picture of the user' do
    visit user_path(@user)
    expect(page).to have_css("img[src*='https://somewhere.com/an_ordinary_photo.jpg']")
  end

  # checks if the user's name can be seen
  it 'should render the user name' do
    visit user_path(@user)
    expect(page).to have_content(@user.name)
  end

  # checks the number of posts the user has written
  it 'should render the number of posts written by the user' do
    visit user_path(@user)
    expect(page).to have_content(@user.posts_count)
  end

  # checks if the user's bio can be seen
  it 'should render the bio of the user' do
    visit user_path(@user)
    expect(page).to have_content(@user.bio)
  end

  # checks the user's first 3 posts can be seen
  it 'should render the first 3 posts of the user' do
    # create a posts to use in our tests
    posts = [
      { title: 'trail',
        text: 'answer bent visitor raw stock elephant roof supper numeral bend previous donkey stand wild there' },
      { title: 'sweater',
        text: 'end me low officer enjoy cool phrase could shut cattle military chair parent fruit sunlight with' },
      { title: 'outer',
        text: 'teach soon origin calm crew writing bee sheep brave create saved remember must unless any society' }
    ]

    posts.each do |post_attrs|
      Post.create(author: @user, **post_attrs).save
    end
    visit user_path(@user)
    posts.first(3).each do |post|
      expect(page).to have_content(post[:title])
    end
  end
end
