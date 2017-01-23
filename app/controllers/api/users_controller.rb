class Api::UsersController < ApplicationController
  include Api::Docs::UsersControllerDoc

  def create
    user = User.new(user_params)
    render :json => request_success(user), status: CREATED if user.save!
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
