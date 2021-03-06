class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :update, :to => :close
    alias_action :finished, :to => :read

    user ||= User.new

    can :manage, :all if user.admin?

    can :read, [World, GameSystem, User, Room, Session, Character, Member]

    if user.persisted?

      # for User Ability
      can :update, User, :id => user.id

      # for World Ability
      can :create, World
      can :manage, World, :owner_id => user.id

      #for Room Ability
      can [:update, :destroy], Room, :user_id => user.id
      can :manage, Room do |room|
        room.roomable.try(:owner) == user
      end

      #for Session Ability
      can :create, Session do |session|
        session.world.try(:user_joined?, user)
      end
      can :manage, Session, :game_master_id => user.id
      can :manage, Session do |session|
        session.world.try(:owner) == user
      end

      #for Session::Applicant Ablity
      can :create, Session::Applicant do |applicant|
        applicant.session.world.try(:user_joined?, user) && !applicant.session.try(:fix_applicant?)
      end
      can :manage, Session::Applicant do |applicant|
        applicant.session.try(:owner) == user
      end

      #for Character Ability
      can :create, Character do |character|
        character.world.try(:user_joined?, user)
      end
      can :manage, Character, :user_id => user.id
      can :manage, Character do |character|
        character.world.try(:owner) == user
      end

      #for Member Ability
      can :create, Member
      can :manage, Member do |member|
        member.world.try(:owner) == user
      end

    end

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
