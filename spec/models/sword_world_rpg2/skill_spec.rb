require 'spec_helper'

describe SwordWorldRpg2::Skill do
  describe "fields" do
    it { should have_field(:name).of_type(String) }
    it { should have_field(:has_mp).of_type(Boolean).with_default_value_of(false) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:has_mp) }
  end

  describe "mass assigment" do
    it { should allow_mass_assignment_of(:name) }
    it { should allow_mass_assignment_of(:has_mp) }

    it { should allow_mass_assignment_of(:name).as(:admin) }
    it { should allow_mass_assignment_of(:has_mp).as(:admin) }
  end
end
