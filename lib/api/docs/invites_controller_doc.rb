module Api::Docs::InvitesControllerDoc
  extend Apipie::DSL::Concern
  extend Api::Docs::HttpErrorsHelper

  api :GET, 'api/events/:event_id/invites'
  param :access_token, String, required: true
  description 'Show current event invites'
  er401

  def index; end

  api :POST, 'api/events/:event_id/invites'
  param :access_token, String, required: true
  description 'Create new invite'
  param :invited_user_id, Integer, required: true
  er422
  er401

  def create; end

  api :DELETE, 'api/events/:event_id/invites/:id'
  param :access_token, String, required: true
  param :id, :number, require: true
  er404
  er401

  def destroy; end
end
