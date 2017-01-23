class ApplicationController < ActionController::Base
  include Api::Errors::Codes

  UNAUTH_MESSAGE = 'Not authorized'.freeze

  protect_from_forgery with: :null_session

  { ActiveRecord::RecordNotFound => NOT_FOUND,
    ActiveRecord::RecordInvalid => UNPROCESSABLE_ENTITY,
    Api::Errors::PermissionDenied => FORBIDDEN,
    Api::Errors::WrongIntervalFormat => BAD_FORMAT }.each do |exception, http_code|
    rescue_from(exception) { |e| render_with_code(e, http_code) }
  end

  private

  def current_user
    @current_user ||= User.find(doorkeeper_token[:resource_owner_id])
  end

  def doorkeeper_unauthorized_render_options(*)
    { json: { status: 'error', message: UNAUTH_MESSAGE } }
  end

  def render_with_code(exception, code)
    render json: { status: 'error', message: exception.message }, status: code
  end

  def request_success(data)
    { status: 'success', data: data }
  end

  def check_event_permission!(param)
    event = Event.find(params[param])
    raise Api::Errors::PermissionDenied unless event.has_access?(current_user)
  end
end
