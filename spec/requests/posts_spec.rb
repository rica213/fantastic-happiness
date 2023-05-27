require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  # create a user to use in our tests
  user = User.create(name: 'Bunny', photo: 'https://somewhere.com/an_ordinary_photo.jpg', bio: 'Anyone in this world')
  user.save
  # create a post to use in our tests
  post = Post.create(author: user, title: 'Nonsense', text: 'This guy should stop spitting bullshit')
  post.save

  describe 'GET /users/:user_id/posts ____ posts index page' do
    # check response status is correct
    it 'should return the correct http status' do
      get "/users/#{user.id}/posts"
      expect(response).to have_http_status(200)
    end

    # check correct template is rendered
    it 'should render the correct template' do
      get "/users/#{user.id}/posts"
      expect(response).to render_template(:index)
    end

    # check the response body includes correct placeholder text
    it 'should include correct placeholder text in the response body' do
      get "/users/#{user.id}/posts"
      expect(response.body).to include(user.name)
      expect(response.body).to include(post.title)
    end
  end

  describe 'GET /users/:user_id/posts/:id ____ posts show page' do
    # check response status is correct
    it 'should return the correct http status' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to have_http_status(200)
    end

    # check correct template is rendered
    it 'should render the correct template' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response).to render_template(:show)
    end

    # check the response body includes correct placeholder text
    it 'should include correct placeholder text in the response body' do
      get "/users/#{user.id}/posts/#{post.id}"
      expect(response.body).to include(post.title)
    end
  end
end
