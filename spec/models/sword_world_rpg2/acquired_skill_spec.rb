require 'spec_helper'

describe SwordWorldRpg2::AcquiredSkill do
  describe "associations" do
    it { should be_embedded_in(:sword_world_rpg2).as_inverse_of(:acquired_skills) }
    it { should belong_to(:skill).of_type(SwordWorldRpg2::Skill).as_inverse_of(:acquired_skills) }
  end

  describe "fields" do
    it { should have_field(:level).of_type(Integer).with_default_value_of(1) }
  end

  describe "mass assignment" do
    it { should allow_mass_assignment_of(:level) }
    it { should allow_mass_assignment_of(:skill_id) }

    it { should allow_mass_assignment_of(:level).as(:admin) }
    it { should allow_mass_assignment_of(:skill_id).as(:admin) }
  end

  describe "validations" do
    it { should validate_presence_of(:level) }
    it { should validate_presence_of(:skill_id) }
  end
end
