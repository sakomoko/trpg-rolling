require 'spec_helper'
require "cancan/matchers"

describe Session do

  describe "attr_accesible" do
    it { should be_accessible :title }
    it { should be_accessible :description }
    it { should be_accessible :started_at }
    it { should be_accessible :finished_at }
    it { should be_accessible :guidelines }
    it { should be_accessible :published }

    it { should_not be_accessible :id }
    it { should_not be_accessible :world_id }
    it { should_not be_accessible :game_master_id }

    it { should_not be_accessible :finished }
    it { should_not be_accessible :closed_at }

    it { should_not be_accessible :created_at }
    it { should_not be_accessible :updated_at }
  end

  describe "admin attr_accesible" do
    it { should be_admin_accessible :title }
    it { should be_admin_accessible :description }
    it { should be_admin_accessible :started_at }
    it { should be_admin_accessible :finished_at }
    it { should be_admin_accessible :guidelines }
    it { should be_admin_accessible :published }

    it { should be_admin_accessible :world_id }
    it { should be_admin_accessible :game_master_id }

    it { should be_admin_accessible :finished }
    it { should be_admin_accessible :closed_at }
    it { should be_admin_accessible :created_at }
    it { should be_admin_accessible :updated_at }

    it { should_not be_admin_accessible :id }
  end


  describe "ability" do
    subject { ability }
    let(:ability) { Ability.new(user) }
    let(:user) { FactoryGirl.create :user }
    let(:world) { FactoryGirl.create :world }
    named_let(:session) { FactoryGirl.create :session }
    named_let(:new_session) { Session.new }

    context "When access all guest user" do
      let(:user) { FactoryGirl.build :user }
      it { should be_able_to(:read, session)}
      it { should_not be_able_to(:create, new_session)}
      it { should_not be_able_to(:update, session)}
      it { should_not be_able_to(:destroy, session)}
    end

    context "When user own session" do
      named_let(:session) { FactoryGirl.create :session, :game_master => user }
      it { should be_able_to(:manage, session) }
    end

    context "When access other user's session" do
      named_let(:session) { FactoryGirl.create :session }
      it { should be_able_to(:read, session) }
      it { should_not be_able_to(:manage, session) }
      it { should_not be_able_to(:update, session) }
      it { should_not be_able_to(:destroy, session) }
    end

    context "When access logged in user" do
      it { should be_able_to(:read, session) }
      it { should_not be_able_to(:manage, session)}
      it { should_not be_able_to(:update, session)}
      it { should_not be_able_to(:destroy, session)}

      context "When user alredy joined" do
        before do
          world.join user
          new_session.world = world
        end
        it { should be_able_to(:create, new_session) }
      end

      context "When user not joined" do
        before do
          new_session.world = world
        end
        it { should_not be_able_to(:create, new_session) }
      end
    end

    context "When access Session World Owner" do
      let(:world) { FactoryGirl.create :world, :owner => user }
      named_let(:session) { FactoryGirl.create :session, :world => world}
      it { should be_able_to(:manage, session)}
    end
  end

end
