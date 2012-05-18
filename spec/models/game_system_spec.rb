require 'spec_helper'
require "cancan/matchers"

describe GameSystem do

  describe "attr_accesible" do
    it { should be_accessible :name }
    it { should be_accessible :description }
  end

  describe "ability" do
    subject { ability }
    let(:ability) { Ability.new(user) }

    context "When editing by admin" do
      let(:user) { FactoryGirl.create :user, :role => 'admin' }
      it { should be_able_to(:manage, GameSystem.new)}
    end

  end
end
