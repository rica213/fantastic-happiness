class PostsController < ApplicationController
  load_and_authorize_resource

  # GET /users/:user_id/posts
  def index
    @user = User.find(params[:user_id])
    # retrieve posts associated to @user and
    # eager-loading the associated comments
    @posts = @user.posts.includes(comments: [:author])

    # api endpoint to list all posts for a user
    respond_to do |format|
      format.html
      format.json { render json: @posts }
    end
  rescue ActiveRecord::RecordNotFound
    # Handle the case where the user is not found
    # Redirect to the root page
    flash[:error] = 'User not found.'
    redirect_to root_path
  end

  # GET /users/:user_id/posts/:id
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

  def destroy
    @user = User.find(params[:user_id])
    @post = @user.posts.find(params[:id])

    @post.likes.destroy_all
    @post.comments.destroy_all
    @post.destroy

    redirect_to user_posts_path(@user)
  end

  private

  # Whitelist and extract the allowed parameters
  def post_params
    params.require(:post).permit(:title, :text)
  end
end
