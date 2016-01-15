class UserSessionsController < ApplicationController

before_action :must_be_logged_in

  def index
    @user = current_user
    @user_sessions = @user.user_sessions.all
  end

  def destroy
    @user_session = current_user.user_sessions.find(params[:id])
    if @user_session
      @user_session.destroy
      redirect_to user_user_sessions_url(params[:user_id])
    else
      redirect_to root_url
    end
  end


end
