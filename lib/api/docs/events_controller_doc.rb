module Api::Docs::EventsControllerDoc
  extend Apipie::DSL::Concern
  extend Api::Docs::HttpErrorsHelper
  api :GET, '/events'
  param :interval, String, desc: 'Get events in range from today..today + interval. Should be like 2d,2y,14h,2m'
  er406

  def index; end

  api :GET, '/events/feed'
  description 'Show last activity in events where user participate'

  def feed; end

  api :POST, '/events'
  param :purpose, String, required: true
  param :place, String, required: true
  param :event_time, Integer, required: true, desc: 'Should be correct timestamp'
  er422

  def create; end

  api :GET, '/events/:id'
  param :id, :number, require: true
  er404
  er403

  def show; end

  api :PUT, '/events/:id'

  param :id, :number, require: true
  param :purpose, String
  param :place, String
  param :event_time, String
  er422

  def update; end

  api :DELETE, '/events/:id'
  param :id, :number, required: true
  er404

  def destroy; end

end
