# comments_controller.rb
class CommentsController < ApplicationController
  before_action :set_post

  def index
    # @comments = @post.comments.order(updated_at: :asc)
    @comments = @post.comments.where(spam: false).order(updated_at: :asc)
  end

  def create
    @comment = @post.comments.new(comment_params)
    if @comment.save
      redirect_to @post
    else
      render partial: "comments/form", locals: { comment: @comment }, status: :unprocessable_entity
    end
  end

  def edit
    @comment = @post.comments.find(params[:id])
  end

  def update
    @comment = @post.comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to @post
    else
      render partial: "comments/form", locals: { comment: @comment }, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    # redirect_back(fallback_location: root_url)
    head :ok
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end
