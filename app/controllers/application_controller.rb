class ApplicationController < ActionController::Base
  # Make current user data available to all controllers
  def current_user 
    User.first!
  end
end
