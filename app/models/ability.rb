class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= GameTranslator::User.new

    can :translate, :game if user.translator?

    can :manage, GameTranslator::Game if user.translator?

    can :manage, GameTranslator::User if user.reviser?
  end
end
