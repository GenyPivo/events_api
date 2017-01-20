class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :could_not_create

  private
  
  def current_user
    @current_user ||= User.find(doorkeeper_token[:resource_owner_id])
  end

  def record_not_found(exception)
    render json:  preproces_exception_message(exception.message), status: 404
  end

  def could_not_create(exception)
    render json: preproces_exception_message(exception.message), status: 422
  end

  def preproces_exception_message(message)
    { status: 'error', message: message }
  end

  def request_success(data)
    { status: 'success', data: data }
  end

end
