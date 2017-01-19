class Api::EventsController < ApplicationController
  before_action :doorkeeper_authorize!

  def index
    render json: current_user.events.all
  end

  def create
    event = current_user.events.new(event_params)
    event.save
    render nothing: true, status: 201
  end

  def show
    event = current_user.events.find(params[:id])
    render json: event
  end

  def update
    event = current_user.events.find(params[:id])
    event.update(event_params)
    render nothing: true
  end

  def destroy
    current_user.events.delete(params[:id])
    render nothing: true, status: 204
  end

  private

  def event_params
    params[:event_time] = DateTime.strptime(params[:event_time],'%s')
    params.permit(:place, :purpose, :event_time, :user_id)
  end
end
