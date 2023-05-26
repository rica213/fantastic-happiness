require 'rails_helper'

RSpec.describe 'Users', type: :request do
  # create a user to use in our tests
  user = User.create(name: 'Bunny', photo: 'https://somewhere.com/an_ordinary_photo.jpg', bio: 'Anyone in this world')
  user.save

  describe 'GET /' do
    it 'should return the root page' do
      get '/'
      expect(response).to have_http_status(200)
    end
  end
  describe 'GET /users ___ users index page' do
    # check response status is correct
    it 'should return the correct http status' do
      get '/users'
      expect(response).to have_http_status(200)
    end

    # check correct template is rendered
    it 'should render the correct template' do
      get '/users'
      expect(response).to render_template(:index)
    end

    # check the response body includes correct placeholder text
    it 'should include correct placeholder text in the response body' do
      get '/users'
      expect(response.body).to include(user.name)
    end
  end
  describe 'GET /users/:id ___ users show' do
    # check response status is correct
    it 'should return the correct http status' do
      get "/users/#{user.id}"
      expect(response).to have_http_status(200)
    end

    # check correct template is rendered
    it 'should render the correct template' do
      get "/users/#{user.id}"
      expect(response).to render_template(:show)
    end

    # check the response body includes correct placeholder text
    it 'should include correct placeholder text in the response body' do
      get "/users/#{user.id}"
      expect(response.body).to include(user.name)
    end
  end
end
