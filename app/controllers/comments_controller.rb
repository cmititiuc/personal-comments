class CommentsController < ApplicationController
  def index
    @comments = Comment.all
    @comments = @comments.where('commentable_id = ?', params[:filter]) if params[:filter]
  end

  def new
    @comment = Comment.new
  end

  def create
    @commentable = params[:comment][:commentable_type].constantize.find(params[:comment][:commentable_id]) rescue nil
    if @commentable
      @comment = @commentable.comments.new(comment_params)
    else
      @commentable = comments_path
      @comment = Comment.new(comment_params)
    end
    if @comment.save
      redirect_to @commentable, notice: "Comment created."
    else
      render :new
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:comment, :commentable_type, :commentable_id)
    end
end
