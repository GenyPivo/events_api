module Api::Docs::HttpErrorsHelper
  include Api::Errors::Codes
  def er422
    error UNPROCESSABLE_ENTITY, 'In case if invalid input data'
  end

  def er404
    error NOT_FOUND, 'Record not found'
  end

  def er406
    error BAD_FORMAT, 'In case if invalid interval format'
  end

  def er403
    error FORBIDDEN, 'Permission denied'
  end

end