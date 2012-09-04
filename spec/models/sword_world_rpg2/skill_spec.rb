require 'spec_helper'

describe SwordWorldRpg2::Skill do
  describe "associations" do
#    it { should have_many(:acquired_skills).of_type(SwordWorldRpg2::AcquiredSkill) }
  end
  describe "fields" do
    it { should have_field(:name).of_type(String) }
    it { should have_field(:has_mp).of_type(Boolean).with_default_value_of(false) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end

  describe "mass assigment" do
    it { should allow_mass_assignment_of(:name) }
    it { should allow_mass_assignment_of(:has_mp) }

    it { should allow_mass_assignment_of(:name).as(:admin) }
    it { should allow_mass_assignment_of(:has_mp).as(:admin) }
  end

  describe "create_seed_data" do
    subject { SwordWorldRpg2::Skill.count}
    let(:skills) {YAML.load_file "#{Rails.root}/db/seeds/sword_world_rpg2/skills.yml"}
    before do
      SwordWorldRpg2::Skill.create_seed_data
    end
    it { should eq skills.count }
  end
end
