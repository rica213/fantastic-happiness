require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /users/:user_id/posts ____ posts index page" do
    # check response status is correct
    it "should return the correct http status" do
      get "/users/1/posts"
      expect(response).to have_http_status(200)
    end

    # check correct template is rendered
    it "should render the correct template" do
      get "/users/1/posts"
      expect(response).to render_template(:index)
    end

    # check the response body includes correct placeholder text
    it "should include correct placeholder text in the response body" do
      get "/users/1/posts"
      expect(response.body).to include(`<h1>Index page of the Post</h1>`)
    end
  end

  describe "GET /users/:user_id/posts/:id ____ posts show page" do
    # check response status is correct
    it "should return the correct http status" do
      get "/users/1/posts/1"
      expect(response).to have_http_status(200)
    end

    # check correct template is rendered
    it "should render the correct template" do
      get "/users/1/posts/1"
      expect(response).to render_template(:show)
    end

    # check the response body includes correct placeholder text
    it "should include correct placeholder text in the response body" do
      get "/users/1/posts/1"
      expect(response.body).to include(`<h1>Show page of the Post</h1>`)
    end
  end
end