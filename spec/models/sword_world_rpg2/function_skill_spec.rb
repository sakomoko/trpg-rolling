require 'spec_helper'

describe SwordWorldRpg2::FunctionSkill do
  describe "associations" do
    it { should be_embedded_in(:character).of_type(SwordWorldRpg2).as_inverse_of(:function_skills)}
  end

  describe "fields" do
    it { should have_field(:name).of_type(String) }
    it { should have_field(:level).of_type(Integer).with_default_value_of(1) }
  end

  describe "mas assignments" do
    it { should allow_mass_assignment_of(:name) }
    it { should allow_mass_assignment_of(:level) }

    it { should allow_mass_assignment_of(:name).as(:admin) }
    it { should allow_mass_assignment_of(:level).as(:admin) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:level) }
  end
end
