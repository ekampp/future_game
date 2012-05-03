class UsersController < ApplicationController

  #
  # Displays form to create a new user
  #
  def new
    @user = User.new
    respond_with @user
  end

  #
  # Displays the form for editing the users details.
  # Per design, a user can only edit his own profile, unless he has been
  # granted access (e.g. by being an admin).
  #
  def edit
    @user = User.find(params[:id]) if logged_in? and can?(:manage, User)
    @user ||= current_user
    respond_with @user
  end

  #
  # Updates the given user with the putted +user+ params.
  # A user should not be allowed to update any other profile than his own,
  # unless he can manage the user model.
  #
  def update
    @user = User.find(params[:id]) if logged_in? and can?(:manage, User)
    @user ||= current_user
    respond_with @user, location: edit_users_path(@user)
  end

  #
  # Destroys the user
  # Any user can destroy their own profile, but only admins can destroy other
  # users profiles.
  #
  def destroy
    @user = User.find(params[:id])
    raise "No user found!" unless (logged_in? and current_user == @user) or can?(:manage, User)
    @user.destroy
    respond_with @user, location: can?(:manage, User) ? users_path : new_users_path
  end

end
