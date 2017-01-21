class ApplicationController < ActionController::Base
  include Api::Errors::Codes
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  {
      ActiveRecord::RecordNotFound => NOT_FOUND,
      ActiveRecord::RecordInvalid => UNPROCESSABLE_ENTITY,
      Api::Errors::PermissionDenied => FORBIDDEN
  }.each do |exception, http_code|
    rescue_from(exception) { render_with_code(exception, http_code) }
  end


  private
  
  def current_user
    @current_user ||= User.find(doorkeeper_token[:resource_owner_id])
  end

  def doorkeeper_unauthorized_render_options(error: nil)
    { json: { status: 'error', message: "Not authorized" } }
  end

  def render_with_code(exception, code)
    render json: { status: 'error', message: exception.message }, status: code
  end

  def request_success(data)
    { status: 'success', data: data }
  end

end
