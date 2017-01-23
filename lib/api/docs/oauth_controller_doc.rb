module Api::Docs::OauthControllerDoc
  extend Apipie::DSL::Concern
  extend Api::Docs::HttpErrorsHelper


  api :POST, 'oauth/token'
  description 'Get token by credentials'
  param :grant_type, String, required: true, desc: 'grant_type=password'
  param :email, String, required: true
  param :password, String, required: true

  er401('Wrong credentials')

  def create; end

end
