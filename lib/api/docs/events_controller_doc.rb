module Api::Docs::EventsControllerDoc
  extend Apipie::DSL::Concern
  extend Api::Docs::HttpErrorsHelper

  api :GET, 'api/events'
  desc = 'Get events in range from today..today + interval. Should be like 2d,2y,14h,2m'
  param :interval, String, desc: desc
  param :access_token, String, required: true
  er406
  er401

  def index; end

  api :GET, 'api/events/feed'
  param :access_token, String, required: true
  description 'Show last activity in events where user participate'
  er401

  def feed; end

  api :POST, 'api/events'
  param :access_token, String, required: true
  param :purpose, String, required: true
  param :place, String, required: true
  param :event_time, Integer, required: true, desc: 'Should be correct timestamp'
  er422
  er401

  def create; end

  api :GET, 'api/events/:id'
  param :access_token, String, required: true
  param :id, :number, require: true
  er404
  er403
  er401

  def show; end

  api :PUT, 'api/events/:id'
  param :access_token, String, required: true
  param :id, :number, require: true
  param :purpose, String
  param :place, String
  param :event_time, String
  er422
  er401

  def update; end

  api :DELETE, 'api/events/:id'
  param :access_token, String, required: true
  param :id, :number, required: true
  er404
  er401

  def destroy; end
end
