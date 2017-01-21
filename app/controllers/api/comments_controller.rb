class Api::CommentsController < ApplicationController
  before_action :doorkeeper_authorize!
  before_action { check_event_permission! :event_id }

  def index
    comments = Event.find(params[:event_id]).comments
    render json: request_success(comments)
  end

  def create
    event = Event.find(params[:event_id])
    comment = event.comments.new(comment_params)
    comment.user_id = current_user.id
    render json: request_success(comment), status: CREATED if comment.save!
  end

  def update
    comment = current_user.comments.find(params[:id])
    comment.update(comment_params)
    render json: request_success(comment)
  end

  def destroy
    current_user.comments.delete(params[:id])
    render nothing: true, status: NO_CONTENT
  end

  private

  def comment_params
    params.permit(:message)
  end

end
