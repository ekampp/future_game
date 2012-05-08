require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery

  #
  # Checks if a user is logged in
  #
  def logged_in?
    !!current_user
  end

  #
  # Returns the currently logged in user based on a session stored on his
  # computer.
  #
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id].present?
  end

  #
  # Sets the +current_user+, effectively logging him in.
  #
  def current_user= user
    if user.present? and user.valid?
      session[:user_id] = user.id
      @current_user = user
    end
  end

  #
  # Stores the current location
  #
  # Options
  #   * +force+ will force the current location as the stored one.
  #
  def store_location location = nil
    session[:stored_location] = location || request.fullpath
  end

  #
  # Gets the stored location.
  # If there is no stored location, this will default to (1) the
  # +my_account_path+ or (2) the +root_path+.
  #
  def get_stored_location
    loc = session[:stored_location]
    loc ||= my_account_path if logged_in?
    loc ||= root_path
    loc
  end

  #
  # Ensures that the user is logged in, before proceeding
  #
  def require_login
    access_denied unless logged_in?
  end

  #
  # Redirects the user to the login page, and displays a message explaining the
  # reason for the login.
  #
  def access_denied msg = "login_required"
    store_location
    redirect_to login_path(msg: msg) and return
  end
end
