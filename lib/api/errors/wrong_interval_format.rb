class Api::Errors::WrongIntervalFormat < StandardError
  def message
    'Wrong interval format. It should be like 2d|1y|3m|10h'
  end
end
