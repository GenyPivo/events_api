module Api::Docs::CommentsControllerDoc
  extend Apipie::DSL::Concern
  extend Api::Docs::HttpErrorsHelper

  api :GET, '/events/:event_id/comments'
  description 'Show current event comments'

  def index; end

  api :POST, '/events/:event_id/comments'
  description 'Create new comment'
  param :message, String, required: true
  param :document, File
  er422
  er403

  def create; end


  api :PUT, '/events/:event_id/comments/:id'
  param :id, :number, required: true
  param :message, String
  param :document, File
  er422
  er404
  er403

  def update; end

  api :DELETE, '/events/:event_id/comments/:id'
  param :id, :number, required: true
  er404
  er403

  def destroy; end

end
