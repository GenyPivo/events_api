class Api::EventsController < ApplicationController
  before_action :doorkeeper_authorize!
  before_action -> { check_event_permission! :id }, only: :show

  DELETE_MESSAGE = 'Event deleted'.freeze

  def index
    render json: request_success(current_user.events.all)
  end

  def create
    event = current_user.events.new(event_params)
    render json: request_success(event), status: CREATED if event.save!
  end

  def show
    event = events.find(params[:id])
    render json: request_success(event)
  end

  def update
    event = current_user.events.find(params[:id])
    event.update(event_params)
    render json: request_success(event)
  end

  def destroy
    current_user.events.delete(params[:id])
    render json: request_success(DELETE_MESSAGE), status: NO_CONTENT
  end

  private

  def event_params
    params[:event_time] = DateTime.strptime(params[:event_time],'%s')
    params.permit(:place, :purpose, :event_time, :user_id)
  end
end
