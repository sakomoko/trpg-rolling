class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.find(params[:id])
  end

  def info
    @user = current_user
    respond_with({
                   "id" => @user.id,
                   "name" => @user.name,
                   "socket_token" => @user.authentication_token
                 })
  end
end
