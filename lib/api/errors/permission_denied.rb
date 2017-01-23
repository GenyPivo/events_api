class Api::Errors::PermissionDenied < StandardError
  def message
    'Permission denied'
  end
end
