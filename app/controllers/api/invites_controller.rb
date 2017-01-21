class Api::InvitesController < ApplicationController
  before_action :doorkeeper_authorize!

  def index
    invites = current_user.events.find(params[:event_id]).invites
    render json: request_success(invites)
  end

  def create
    event = current_user.events.find(params[:event_id])
    invite = event.invites.new(invites_params)
    invite.user_id = current_user.id
    render json: request_success(invite), status: CREATED if invite.save!
  end

  def destroy
    current_user.invites.delete(params[:id])
    render nothing: true, status: NO_CONTENT
  end

  private

  def invites_params
    params.permit(:invited_user_id)
  end
end
