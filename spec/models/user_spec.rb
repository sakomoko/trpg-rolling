require 'spec_helper'
require "cancan/matchers"

describe User do
  describe "abilities" do
    subject { ability }
    let(:ability) { Ability.new(user) }
    named_let(:user) { Factory :user }
    context "When editing self own" do
      it { should be_able_to(:read, user) }
      it { should be_able_to(:update, user) }
      it { should_not be_able_to(:create, user) }
    end

    context "When editing other user" do
      named_let(:other_user) { Factory :user }
      it { should be_able_to(:read, other_user) }
      it { should_not be_able_to(:update, other_user) }
      it { should_not be_able_to(:create, other_user) }
      it { should_not be_able_to(:destroy, other_user) }
    end
  end
end
