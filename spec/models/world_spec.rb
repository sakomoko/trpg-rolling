require 'spec_helper'
require "cancan/matchers"

describe World do

  describe "attr_accesible" do
    it { should be_accessible :name }
    it { should be_accessible :description }
    it { should be_accessible :open }
    it { should be_accessible :game_system_id }

    it { should_not be_accessible :id }
    it { should_not be_accessible :owner_id }
    it { should_not be_accessible :latest_session_at }

    it { should_not be_accessible :created_at }
    it { should_not be_accessible :updated_at }
    it { should_not be_accessible :deleted_at }
  end


  describe "ability" do
    subject { ability }
    let(:ability) { Ability.new(user) }
    let(:user) { Factory :user }
    named_let(:world) { Factory :world }
    named_let(:new_world) { World.new }

    context "When access all guest user" do
      let(:user) { Factory.build :user }
      it { should be_able_to(:read, world)}
      it { should_not be_able_to(:create, new_world)}
      it { should_not be_able_to(:update, world)}
      it { should_not be_able_to(:destroy, world)}
    end

    context "When user own world" do
      named_let(:world) { Factory :world, :owner => user }
      it { should be_able_to(:manage, world) }
    end

    context "When access other user own world" do
      named_let(:world) { Factory :world }
      it { should be_able_to(:read, world) }
      it { should_not be_able_to(:manage, world) }
      it { should_not be_able_to(:update, world) }
      it { should_not be_able_to(:destroy, world) }
    end

    context "When access logged in user" do
      it { should be_able_to(:create, new_world) }
      it { should be_able_to(:read, world) }
      it { should_not be_able_to(:manage, world)}
      it { should_not be_able_to(:update, world)}
      it { should_not be_able_to(:destroy, world)}
    end
  end

end
