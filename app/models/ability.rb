class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # Admins
    if user.role == "admin"
      can :manage, :all
    end

    # Players
    if user.role == "player"
      can :read, :all

      # Setting user model permissions
      can :create, User
      can :manage, User, id: user.id

      # Setting character model permissions
      can :create, Character
      can :manage, Character, user_id: user.id
    end
  end
end
