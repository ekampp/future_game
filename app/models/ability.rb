class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    case user.role
    when "admin"
      can :manage, :all
    else
      can :read, :all
    end
  end
end
