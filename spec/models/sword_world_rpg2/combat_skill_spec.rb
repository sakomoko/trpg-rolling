require 'spec_helper'

describe SwordWorldRpg2::CombatSkill do
  describe "associations" do
    it { should have_and_belong_to_many(:characters).of_type(SwordWorldRpg2) }
  end

  describe "fields" do
    it { should have_field(:name).of_type(String) }
    it { should have_field(:description).of_type(String) }
  end

  describe "mass assignments" do
    it { should_not allow_mass_assignment_of(:name) }
    it { should_not allow_mass_assignment_of(:description) }

    it { should allow_mass_assignment_of(:character_ids).as(:admin) }
    it { should allow_mass_assignment_of(:name).as(:admin) }
    it { should allow_mass_assignment_of(:description).as(:admin) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }

    it { should validate_presence_of(:description) }
  end
end
