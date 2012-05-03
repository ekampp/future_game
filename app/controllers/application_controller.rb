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
    true
  end
end
