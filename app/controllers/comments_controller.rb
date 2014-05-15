class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index
    @comments = Comment.all
    @comments = @comments.where('commentable_id = ?', params[:filter]) if params[:filter]
  end

  def show
  end

  def new
    @comment = Comment.new
  end

  def edit
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
      if params[:return]
        redirect_to params[:return], notice: "Comment created."
      else
        redirect_to @commentable, notice: "Comment created."
      end
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:comment, :commentable_type, :commentable_id, :return)
    end
end
