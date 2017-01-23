module Api::Docs::InvitesControllerDoc
  extend Apipie::DSL::Concern
  extend Api::Docs::HttpErrorsHelper

  api :GET, '/events/:event_id/invites'
  description 'Show current event invites'

  def index; end

  api :POST, '/events/:event_id/invites'
  description 'Create new invite'
  param :invited_user_id, Integer, required: true
  er422

  def create; end


  api :DELETE, '/events/:event_id/invites/:id'
  param :id, :number, require: true
  er404

  def destroy; end

end
