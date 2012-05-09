class SessionsController < ApplicationController

  def create
    @user = User.find_or_initialize_by auth_hash
    logger.debug "Found user: #{@user.inspect}"
    if @user.present? and @user.save
      self.current_user = @user
      logger.debug "Stored location: #{get_stored_location}"
      redirect_to get_stored_location
    else
      render :new
    end
  end

  def new
    if logged_in?
      redirect_to my_account_path
    else
      render :new
    end
  end

protected

  #
  # Returns the omniauth env hash
  #
  def auth_hash
    request.env['omniauth.auth'].with_indifferent_access
  end

end
