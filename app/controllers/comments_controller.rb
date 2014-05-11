class CommentsController < ApplicationController
  def create
    # TODO: this only allows comments for events (param should be :commentable_id, probably)
    @commentable = Event.find(params[:event_id])
    # TODO: find out what parameters need permitting, and permit them
    params.permit!
    @comment = @commentable.comments.new(params[:comment])
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
      # TODO: I don't think :event_id should be in here, see above todos
      params.require(:comment).permit(:comment, :event_id)
    end
end
