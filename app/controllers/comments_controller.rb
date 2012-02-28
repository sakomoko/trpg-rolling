class CommentsController < ApplicationController

  # POST /sessions/1/comemnts
  # POST /sessions/1/comments.xml
  def create
    @comment = Comment.new(params[:comment])
    @session = Session.find(params[:session_id])
    @comment.commentable = @session
    @comment.user = current_user
    @comment.save
    respond_with(@session, @comment)
  end

end
