#Empty controller for doc. Yeah, bad solution( But for some reasons after inheriting from
#Doorkeeper::Tokens controller apipie method api raise error
#TODO Research it
class Doc::OauthController < ApplicationController
  include Api::Docs::OauthControllerDoc

end
