class UsersController < ApplicationController

  #
  # All actions, except for user creation process, requires that the user is
  # logged in.
  #
  before_filter :require_login, :except => [ :new, :create ]

  #
  # Displays form to create a new user
  # If the user is already logged in, it will redirect him to his account page.
  #
  def new
    unless logged_in?
      @user = User.new
      respond_with @user
    else
      redirect_to my_account_path
    end
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
  # Attempts to create a new user from post data. This requires no login, but
  # it does require the user to confirm his email, after signing up.
  #
  # TODO: Email the user after signup, unless he signed up from an external
  #       vendor <emil@kampp.me>
  # TODO: Create the +thanks-for-signing-up+ static html page.
  #       <emil@kampp.me>
  #
  def create
    @user = User.create(params[:user])
    respond_with @user, location: "/thanks-for-signing-up"
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
