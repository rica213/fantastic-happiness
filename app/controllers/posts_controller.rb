class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    # retrieve posts associated to @user and
    # eager-loading the associated comments
    @posts = @user.posts.includes(:comments)
  end

  def show
    @user = User.find(params[:user_id])
    # retrieve the post associated to @user and
    # eager-loading the associated comments
    @post = @user.posts.includes(:comments).find(params[:id])
  end
end
