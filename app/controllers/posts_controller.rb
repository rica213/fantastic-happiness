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

  def new
    @post = Post.new
  end

  def create
    # create a new post associated to the current_user
    @post = current_user.posts.create(post_params)
    @post.author = current_user

    if @post.save
    # if post saved, redirect to the user's posts and render success message
    redirect_to user_posts_path(current_user), notice: 'Post created successfully.'
    else
      # if post not saved, render new template and render error message
      render :new, notice: 'Post could not be created.'
    end
  end

  private

  # Whitelist and extract the allowed parameters
  def post_params
    params.require(:post).permit(:title, :text)
  end
end
