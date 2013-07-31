class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= GameTranslator::User.new

    can :manage, GameTranslator::Game if user.translator?

    can :manage, GameTranslator::User if user.reviser?

    can :manage, GameTranslator::Language if user.reviser?

    can :manage, :review if user.reviser?
  end
end
