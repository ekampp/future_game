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
    end
  end
end
