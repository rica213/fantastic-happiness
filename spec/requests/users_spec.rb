require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /" do
    it "should return the root page" do
      get "/"
      expect(response).to have_http_status(200)
    end
  end
  describe "GET /users ___ users index page" do
    # check response status is correct
    it "should return the correct http status" do
      get "/users"
      expect(response).to have_http_status(200)
    end

    #check correct template is rendered
    it "should render the correct template" do
      get "/users"
      expect(response).to render_template(:index)
    end

    # check the response body includes correct placeholder text
    it "should include correct placeholder text in the response body" do
      get "/users"
      expect(response.body).to include(`<h1>This is the index page of the users controller</h1>`)
    end
  end
  describe "GET /users/:id ___ users show" do
    # check response status is correct
    it "should return the correct http status" do
      user_id = 1
      get "/users/#{user_id}"
      expect(response).to have_http_status(200)
    end

    # check correct template is rendered
    it "should render the correct template" do
      user_id = 1
      get "/users/#{user_id}"
      expect(response).to render_template(:show)
    end

    # check the response body includes correct placeholder text
    it "should include correct placeholder text in the response body" do
      user_id = 1
      get "/users/#{user_id}"
      expect(response.body).to include(`<h1>This is the show page of the users controller</h1>`)
    end
  end
end