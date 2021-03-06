require 'spec_helper'
require "cancan/matchers"

describe User do

  describe "attr_accesible" do
    it { should be_accessible :name }
    it { should be_accessible :email }
    it { should be_accessible :password }
    it { should be_accessible :password_confirmation }
    it { should be_accessible :remember_me }

    it { should_not be_accessible :id }
    it { should_not be_accessible :rorle }
  end


  describe "#admin?" do
    subject { user }
    context "user is admin" do
      let(:user) { FactoryGirl.create :user, :role => 'admin' }
      it { should be_admin }
    end

    context "user is not admin" do
      let(:user) { FactoryGirl.create :user }
      it { should_not be_admin }
    end

  end

  describe "abilities" do
    subject { ability }
    let(:ability) { Ability.new(user) }
    named_let(:user) { FactoryGirl.create :user }
    context "When editing self own" do
      it { should be_able_to(:read, user) }
      it { should be_able_to(:update, user) }
      it { should_not be_able_to(:create, user) }
    end

    context "When editing other user" do
      named_let(:other_user) { FactoryGirl.create :user }
      it { should be_able_to(:read, other_user) }
      it { should_not be_able_to(:update, other_user) }
      it { should_not be_able_to(:create, other_user) }
      it { should_not be_able_to(:destroy, other_user) }
    end
  end
end
