class SessionsController < ApplicationController
  before_action :must_not_be_logged_in, only: :new

  def create
    if @user = User.find_by_credentials(params[:session][:user_name], params[:session][:password])
      login_user!(@user)
    else
      render :new
    end
  end

  def destroy
    session_token = session[:session_token]
    if current_user
      current_user.destroy_this_session!(session_token)
    end
    session[:session_token] = ''
    redirect_to root_url
  end

  def new
  end

end
