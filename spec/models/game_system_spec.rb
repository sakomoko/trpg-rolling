require 'spec_helper'
require "cancan/matchers"

describe GameSystem do

  describe "associations" do
    it { should have_many(:characters).of_type(Character) }
    it { should have_many(:worlds).of_type(World) }
  end

  describe "attr_accesible" do
    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :description }
    it { should allow_mass_assignment_of :system_key }

    it { should_not allow_mass_assignment_of :id }
  end

  describe "admin attr_accesible" do
    it { should allow_mass_assignment_of(:name).as(:admin) }
    it { should allow_mass_assignment_of(:description).as(:admin) }
    it { should allow_mass_assignment_of(:system_key).as(:admin) }

    it { should_not allow_mass_assignment_of(:id).as(:admin) }
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
