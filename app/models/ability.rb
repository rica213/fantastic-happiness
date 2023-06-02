class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the user here.
    user ||= User.new

    can :read, :all
    can :create, [Post, Comment]

    return unless user.present?

    can :manage, Post, author_id: user.id
    can :manage, Comment, author_id: user.id

    return unless user.admin?

    can :manage, :all

    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
