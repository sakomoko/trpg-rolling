require 'spec_helper'
require "cancan/matchers"

describe Session do
  describe "ability" do
    subject { ability }
    let(:ability) { Ability.new(user) }
    let(:user) { Factory :user }
    named_let(:session) { Factory :session }
    named_let(:new_session) { Session.new }

    context "When access all guest user" do
      let(:user) { Factory.build :user }
      it { should be_able_to(:read, session)}
      it { should_not be_able_to(:create, new_session)}
      it { should_not be_able_to(:update, session)}
      it { should_not be_able_to(:destroy, session)}
    end

    context "When user own session" do
      named_let(:session) { Factory :session, :game_master => user }
      it { should be_able_to(:manage, session) }
    end

    context "When access other user's session" do
      named_let(:session) { Factory :session }
      it { should be_able_to(:read, session) }
      it { should_not be_able_to(:manage, session) }
      it { should_not be_able_to(:update, session) }
      it { should_not be_able_to(:destroy, session) }
    end

    context "When access logged in user" do
      it { should be_able_to(:create, new_session) }
      it { should be_able_to(:read, session) }
      it { should_not be_able_to(:manage, session)}
      it { should_not be_able_to(:update, session)}
      it { should_not be_able_to(:destroy, session)}
    end

    context "When access Session World Owner" do
      let(:world) { Factory :world, :owner => user }
      named_let(:session) { Factory :session, :world => world}
      it { should be_able_to(:manage, session)}
    end
  end

end
