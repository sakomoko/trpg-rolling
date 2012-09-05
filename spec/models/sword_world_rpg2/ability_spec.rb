require 'spec_helper'

describe SwordWorldRpg2::Ability do

  describe "associations" do
    it { should be_embedded_in(:character).of_type(SwordWorldRpg2).as_inverse_of(:abilities) }
  end

  describe "fields" do
    it { should have_fields(:name, :description).of_type(String) }
  end

  describe "mass assignments" do
    it { should allow_mass_assignment_of(:name) }
    it { should allow_mass_assignment_of(:description) }

    it { should allow_mass_assignment_of(:name).as(:admin) }
    it { should allow_mass_assignment_of(:description).as(:admin) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end
end
