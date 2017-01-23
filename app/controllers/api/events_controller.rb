class Api::EventsController < ApplicationController
  before_action :doorkeeper_authorize!
  before_action -> { check_event_permission! :id }, only: :show

  FEED_TIME_RANGE = 7.days

  def index

    if params[:interval].try(:length)
      render json: request_success(Event.where(event_time: DateTime.now..parse_interval(params[:interval])).find_all do
      |ev|
        ev.has_access?(current_user)
      end)
    else
      render json: request_success(Event.all.find_all { |ev| ev.has_access?(current_user) })
    end
  end

  def feed
    date_range = (DateTime.now - FEED_TIME_RANGE)..DateTime.now
    latest = Comment.order('id DESC').where(created_at: date_range).find_all { |com| com.has_access?(current_user) }
    render json: request_success(latest)
  end

  def create
    event = current_user.events.new(event_params)
    render json: request_success(event), status: CREATED if event.save!
  end

  def show
    event = Event.find(params[:id])
    render json: request_success(event)
  end

  def update
    event = current_user.events.find(params[:id])
    event.update(event_params)
    render json: request_success(event)
  end

  def destroy
    current_user.events.delete(params[:id])
    render json: {}, status: NO_CONTENT
  end

  private

  def event_params
    params[:event_time] = DateTime.strptime(params[:event_time], '%s')
    params.permit(:place, :purpose, :event_time, :user_id)
  end

  def parse_interval(interval)
    interval_data = interval.match('(\d+)(\w){1}')
    nums = interval_data[1]
    sufix = interval_data[2]
    DateTime.now + case sufix
                     when 'd'
                       nums.to_i.days
                     when 'm'
                       nums.to_i.month
                     when 'y'
                       nums.to_i.year
                     when 'h'
                       nums.to_i.hours
                     else
                       raise Api::Errors::WrongIntervalFormat
                   end
  end
end
