class Api::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    render :json => user.to_json, status: CREATED if user.save!
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
