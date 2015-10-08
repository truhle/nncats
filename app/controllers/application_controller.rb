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
    @current_user ||= User.find_by(id: user_id_from_session_token)
  end

  helper_method :current_user


  def logged_in?
    !current_user.blank?
  end

  def login_user!(user)
    session[:session_token] = user.set_session_token!.session_token
    attributes = get_session_attributes
    this_session = user.user_sessions.find_by(session_token: session[:session_token])
    user.set_session_attributes(session: this_session, attributes: attributes)
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

private

  def get_session_attributes
    user_agent = request.env["HTTP_USER_AGENT"]
    client = DeviceDetector.new(user_agent)
    if client.known?
      browser = client.name
      device = client.device_name
      os = "#{client.os_name} #{client.os_full_version}"
      attributes = {
        browser: browser,
        device:  device,
        os:      os
      }
    else
      attributes = {
        browser: "Unknown"
      }
    end
  end

  def user_id_from_session_token
    this_session = UserSession.find_by(session_token: session[:session_token])
    if this_session
      this_session.user_id
    end
  end
end
