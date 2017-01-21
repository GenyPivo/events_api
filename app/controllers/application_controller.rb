class ApplicationController < ActionController::Base
  include Api::Errors::HTTPCodes
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :could_not_create
  rescue_from Api::Errors::PermissionDenied, with: :permission_denied

  private
  
  def current_user
    @current_user ||= User.find(doorkeeper_token[:resource_owner_id])
  end

  def record_not_found(exception)
    render_with_code exception, NOT_FOUND
  end

  def could_not_create(exception)
    render_with_code exception, UNPROCESSABLE_ENTITY
  end

  def permission_denied(exception)
    render_with_code exception, FORBIDDEN
  end

  def render_with_code(exception, code)
    render json: { status: 'error', message: exception.message }, status: code
  end

  def request_success(data)
    { status: 'success', data: data }
  end

end
