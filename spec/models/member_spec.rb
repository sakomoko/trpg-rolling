require 'spec_helper'

describe Member do
  it { should be_timestamped_document }

  describe "associations" do
    it { should be_embedded_in(:world) }
    it { should belong_to(:user) }
  end

  describe "fields" do
    it { should have_field(:status).of_type(Symbol).with_default_value_of(:approved) }
  end

  describe "validations" do
    it { should validate_inclusion_of(:status).to_allow([:approved, :awaiting]) }
  end

  describe "mass assignements" do
    it { should_not allow_mass_assignment_of(:status) }

    it { should allow_mass_assignment_of(:status).as(:admin) }
    it { should allow_mass_assignment_of(:user).as(:admin) }
  end

  describe "abilities" do
  end
end
