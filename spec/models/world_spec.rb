require 'spec_helper'
require "cancan/matchers"

describe World do

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
