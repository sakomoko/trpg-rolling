require 'spec_helper'

describe Session::Applicant do
  describe "associations" do
    it { should be_embedded_in :session }
    it { should belong_to :character }
  end

  describe "fields" do
    it { should have_field(:status).of_type(Symbol).with_default_value_of(:entry) }
    it { should have_field(:comment).of_type(String) }
  end

  describe "validations" do
    it { should validate_presence_of(:character_id) }
    it { should validate_inclusion_of(:status).to_allow([:entry, :approved]) }
  end

  describe "mass assignments" do
    it { should allow_mass_assignment_of :comment }
    it { should_not allow_mass_assignment_of(:character_id) }
    it { should_not allow_mass_assignment_of(:status) }

    it { should allow_mass_assignment_of(:comment).as(:admin) }
    it { should allow_mass_assignment_of(:status).as(:admin) }
    it { should allow_mass_assignment_of(:character_id).as(:admin) }
  end

end
