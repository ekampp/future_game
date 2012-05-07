class UsersController < InheritedResources::Base
  before_filter :require_login, :except => [ :new, :create ]
  load_and_authorize_resource

  #
  # Displays form to create a new user
  # If the user is already logged in, it will redirect him to his account page.
  #
  def new
    new! do |format|
      format.html do
        if logged_in?
          redirect_to my_account_path
        else
          respond_with resource
        end
      end
    end
  end

  #
  # Updates the given user with the putted +user+ params.
  # A user should not be allowed to update any other profile than his own,
  # unless he can manage the user model.
  #
  def update
    update! do |format|
      format.html do
        respond_with resource, location: edit_user_path(resource)
      end
    end
  end

  #
  # Attempts to create a new user from post data. This requires no login, but
  # it does require the user to confirm his email, after signing up.
  #
  # TODO: Create the +thanks-for-signing-up+ static html page.
  #       <emil@kampp.me>
  #
  def create
    create! do |format|
      format.html do
        respond_with resource, location: new_character_path
      end
    end
  end

  #
  # Destroys the user
  # Any user can destroy their own profile, but only admins can destroy other
  # users profiles.
  #
  def destroy
    destroy! do |format|
      format.html do
        respond_with resource, location: current_user.role == "admin" ? users_path : new_user_path
      end
    end
  end
end
