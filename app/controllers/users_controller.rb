class UsersController < ApplicationController

  before_action :logged_in_user, only: :new

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_name: params[:user][:user_name])
    @user.password = params[:user][:password]
    if @user.save
      login_user!(@user)
    else
      render :new
    end
  end

end
