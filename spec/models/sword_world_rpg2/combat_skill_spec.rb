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

  describe "create_seed_data" do
    subject { SwordWorldRpg2::CombatSkill.count}
    let(:skills) {YAML.load_file "#{Rails.root}/db/seeds/sword_world_rpg2/combat_skills.yml"}
    before do
      SwordWorldRpg2::CombatSkill.create_seed_data
    end
    it { should eq skills.count }
  end
end
