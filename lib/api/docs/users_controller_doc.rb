module Api::Docs::UsersControllerDoc
  extend Apipie::DSL::Concern
  extend Api::Docs::HttpErrorsHelper

  api :POST, 'api/users'
  description 'Create new user'
  param 'user[email]', String, required: true
  param 'user[password]', String, required: true
  er422

  def create; end

end
