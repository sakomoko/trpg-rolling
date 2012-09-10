require 'spec_helper'

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
end
