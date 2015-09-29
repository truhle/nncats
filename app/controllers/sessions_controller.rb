class SessionsController < ApplicationController
  before_action :logged_in_user, only: :new

  def create
    if @user = User.find_by_credentials(params[:session][:user_name], params[:session][:password])
      login_user!(@user)
    else
      render :new
    end
  end

  def destroy
    if current_user
      current_user.reset_session_token!
    end
    session[:session_token] = ''
    redirect_to root_url
  end

  def new
  end

end
