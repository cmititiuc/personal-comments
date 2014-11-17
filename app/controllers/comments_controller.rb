class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy, :get_comment]

  def index
    @comment = Comment.new
    @comments = current_user.comments
    @comments = @comments.where('commentable_id = ?', params[:filter]) if params[:filter]
  end

  def show
  end

  def new
    @comment = Comment.new
  end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    # @commentable = params[:comment][:commentable_type].constantize.find(params[:comment][:commentable_id]) rescue nil
    # if @commentable
    #   @comment = @commentable.comments.new(comment_params)
    # else
      @commentable = comments_path
      @comment = current_user.comments.build(comment_params)
    # end
 
    respond_to do |format|
      if @comment.save
        format.html { redirect_to params[:return] ? params[:return] : @commentable, notice: "Comment created." }
        format.js { render :create, :locals=>{ notice: 'Comment created.' } }
      else
        format.html { render :new }
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to params[:return_path] ? params[:return_path] : @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
        format.js { render :update, :locals=>{ notice: 'Comment was successfully updated.' } }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to params[:return_path] ? params[:return_path] : comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
      format.js { render :plain=>'Comment was successfully destroyed.' }
    end
  end

  def get_comment # maybe rename this 'get_form'?
    render :partial=>'comments/form', :locals=>{ :height=>params[:height], :return_path=>params[:return_path] }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = current_user.comments.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:comment, :commentable_type, :commentable_id, :return)
    end
end
