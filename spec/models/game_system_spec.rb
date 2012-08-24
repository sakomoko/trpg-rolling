require 'spec_helper'
require "cancan/matchers"

describe GameSystem do

  describe "attr_accesible" do
    it { should be_accessible :name }
    it { should be_accessible :description }
    it { should be_accessible :system_key }

    it { should_not be_accessible :id }
  end

  describe "admin attr_accesible" do
    it { should be_admin_accessible :name }
    it { should be_admin_accessible :description }
    it { should be_admin_accessible :system_key }

    it { should_not be_admin_accessible :id }
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
