class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def cat_owner?
    @cat = current_user.cats(cat_id)
    if @cat.blank?
      redirect_to root_url
    else
      true
    end
  end

  def current_user
    @current_user = User.find_by(session_token: session[:session_token])
  end

  helper_method :current_user


  def logged_in?
    !current_user.blank?
  end

  def login_user!(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
    redirect_to root_url
  end

  def must_be_logged_in
    unless logged_in?
      redirect_to root_url
    end
  end

  def must_not_be_logged_in
    if logged_in?
      redirect_to root_url
    end
  end
end
