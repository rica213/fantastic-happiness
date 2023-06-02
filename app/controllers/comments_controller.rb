class CommentsController < ApplicationController
  # user_post_comments
  # GET /users/:user_id/posts/:post_id/comments
  def index
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comments = @post.comments.includes(:author)

    # api endpoint to list all comments for a user's post
    render json: @comments
  end

  # new_user_post_comment
  # GET /users/:user_id/posts/:post_id/comments/new
  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  # user_post_comments
  # POST /users/:user_id/posts/:post_id/comments
  def create
    @comment = current_user.comments.create(comment_params)
    @comment.post_id = params[:post_id]

    if @comment.save
      respond_to do |format|
        format.html {redirect_to user_posts_path(@post.author, @post), notice: 'Comment created successfully.' }
        format.json { render json: @comment, status: :created}
      end

    else
      respond_to do |format|
        format.html { render :new, notice: 'Comment failed to be created.' }
        format.json { render json: @comment.errors, status: :unprocessable_entry }
      end
    end
  end

  # DELETE /users/:user_id/posts/:id
  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy

    redirect_to user_posts_path(@post)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
