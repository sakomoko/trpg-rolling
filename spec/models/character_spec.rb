require 'spec_helper'
require "cancan/matchers"

describe Character do

  describe "associations" do
    it { should belong_to(:user) }
    it { should belong_to(:game_system) }
    it { should belong_to(:world) }
  end

  describe "fields" do
    it { should have_field(:name).of_type(String) }
    it { should have_field(:gender).of_type(Symbol).with_default_value_of(:male) }
    it { should have_field(:age).of_type(Integer) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:gender) }
    it { should validate_presence_of(:age) }

    it { should validate_associated(:user) }
    it { should validate_associated(:game_system) }
    it { should validate_associated(:world) }

    it { should validate_inclusion_of(:gender).to_allow([:male, :female]) }
    it { should validate_numericality_of(:age).greater_than(0) }
  end

  describe "mass assignments" do
    it { should allow_mass_assignment_of :name }
    it { should allow_mass_assignment_of :gender }
    it { should allow_mass_assignment_of :age }

    it { should_not allow_mass_assignment_of :user_id }
    it { should_not allow_mass_assignment_of :game_system_id }
    it { should_not allow_mass_assignment_of :world_id }

    context "is admin" do
      it { should allow_mass_assignment_of(:name).as(:admin) }
      it { should allow_mass_assignment_of(:gender).as(:admin) }
      it { should allow_mass_assignment_of(:age).as(:admin) }

      it { should allow_mass_assignment_of(:user_id).as(:admin) }
      it { should allow_mass_assignment_of(:game_system_id).as(:admin) }
      it { should allow_mass_assignment_of(:world_id).as(:admin) }
      it { should allow_mass_assignment_of(:created_at).as(:admin) }
      it { should allow_mass_assignment_of(:updated_at).as(:admin) }
    end
  end

  describe "abilities" do
    subject { ability }
    let(:ability) { Ability.new(user) }
    let(:user) { FactoryGirl.create :user }
    named_let(:character) { FactoryGirl.create :character }
    named_let(:new_character) { Character.new }

    context "When access all guest user" do
      let(:user) { FactoryGirl.build :user }
      it { should be_able_to(:read, character) }
      it { should_not be_able_to(:create, new_character) }
      it { should_not be_able_to(:update, character) }
      it { should_not be_able_to(:destroy, character) }
    end

    context "When user own character" do
      named_let(:character) { FactoryGirl.create :character, user: user }
      it { should be_able_to(:manage, character) }
    end

    context "When access other users character" do
      it { should be_able_to(:read, character) }
      it { should_not be_able_to(:update, character) }
      it { should_not be_able_to(:destroy, character) }
    end

    context "Whenn access World Owner" do
      let(:world) { FactoryGirl.create :world, owner: user }
      named_let(:character) { FactoryGirl.create :character, world: world}
      it { should be_able_to(:manage, character) }
    end

  end
end
