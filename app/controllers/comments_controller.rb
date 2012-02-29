class CommentsController < ApplicationController

  # POST /sessions/1/comemnts
  # POST /sessions/1/comments.xml
  def create
    @session = Session.find(params[:session_id])
    @comment = Comment.create(params[:comment]) do |comment|
      comment.commentable = @session
      comment.user = current_user
    end
    respond_with(@session, @comment)
  end

end
