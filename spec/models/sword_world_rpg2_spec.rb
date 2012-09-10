require 'spec_helper'

describe SwordWorldRpg2 do
  describe "associations" do
    it { should have_and_belong_to_many(:combat_skills).of_type(SwordWorldRpg2::CombatSkill) }
    it { should embed_many(:acquired_skills) }
    it { should embed_many(:abilities).of_type(SwordWorldRpg2::Ability) }
    it { should embed_many(:function_skills).of_type(SwordWorldRpg2::FunctionSkill) }
  end

  describe "attr_accesible" do
    it { should be_accessible :name }
    it { should be_accessible :gender }
    it { should be_accessible :age }

    it { should be_accessible :technique }
    it { should be_accessible :heart }
    it { should be_accessible :physique }

    it { should be_accessible :sub_a }
    it { should be_accessible :sub_b }
    it { should be_accessible :sub_c }
    it { should be_accessible :sub_d }
    it { should be_accessible :sub_e }
    it { should be_accessible :sub_f }

    it { should be_accessible :equipments }
    it { should be_accessible :items }
    it { should be_accessible :honor_items }
    it { should be_accessible :profile }
    it { should be_accessible :memo }

    it { should be_accessible :acquired_skills_attributes }
    it { should be_accessible :abilities_attributes }
    it { should be_accessible :function_skills_attributes }
    it { should be_accessible :combat_skill_ids }

    it { should_not be_accessible :user_id }
    it { should_not be_accessible :game_system_id }
    it { should_not be_accessible :world_id }
  end

  describe "fields" do
    it { should have_fields(:race, :race_bonus, :birth).of_type(String) }
    it { should have_field(:records).of_type(Array).with_default_value_of(["", "", ""])}
    it { should have_fields(:pollution, :experience, :total_experience, :honor, :total_honor).of_type(Integer).with_default_value_of(0) }
    it { should have_fields(:hp_bonus, :mp_bonus, :technique, :heart, :physique).of_type(Integer).with_default_value_of(0) }
    it { should have_fields(:sub_a, :sub_b, :sub_c, :sub_d, :sub_e, :sub_f).of_type(Integer).with_default_value_of(0) }
    it { should have_fields(:grow_dexterity, :grow_agility, :grow_vitality, :grow_strength, :grow_intelligence, :grow_mind).of_type(Integer).with_default_value_of(0) }
    it { should have_fields(:dexterity_equipment, :agility_equipment, :vitality_equipment, :strength_equipment, :intelligence_equipment, :mind_equipment).of_type(Integer).with_default_value_of(0) }
    it { should have_fields(:equipments, :items, :honor_items).of_type(String) }
    it { should have_fields(:profile, :memo).of_type(String) }
  end

  describe "status" do
    let(:character) { FactoryGirl.create :sword_world_rpg2 }
    subject { character }

    context "dexterity" do
      its(:dexterity) { should be_eql (character.technique + character.sub_a + character.grow_dexterity + character.dexterity_equipment) }
    end

    context "agility" do
      its(:agility) { should be_eql (character.technique + character.sub_b + character.grow_agility + character.agility_equipment) }
    end

    context "strength" do
      its(:strength) { should be_eql (character.physique + character.sub_c + character.grow_strength + character.strength_equipment) }
    end

    context "vitality" do
      its(:vitality) { should be_eql (character.physique + character.sub_d + character.grow_vitality + character.vitality_equipment) }
    end

    context "intelligence" do
      its(:intelligence) { should be_eql (character.heart + character.sub_e + character.grow_intelligence + character.intelligence_equipment) }
    end

    context "mind" do
      its(:mind) { should be_eql (character.heart + character.sub_f + character.grow_mind + character.mind_equipment) }
    end
  end

  describe "bonus" do
    let(:character) { FactoryGirl.create :sword_world_rpg2 }
    subject { character }
    [:dexterity, :agility, :strength, :vitality, :intelligence, :mind].each do |status|
      its("#{status}_bonus") { should eq ( (character.send(status) / 6).truncate ) }
    end
  end

  describe "level" do
    let(:character) { FactoryGirl.create :sword_world_rpg2_with_skills }
    subject { character.level }

    context "level 3" do
      it { should eq 3 }
    end

    context "level 5" do
      before do
        character.acquired_skills << FactoryGirl.build(:sword_world_rpg2_acquired_skill, :level => 5)
        character.acquired_skills << FactoryGirl.build(:sword_world_rpg2_acquired_skill, :level => 4)
      end
      it { should eq 5 }
    end
  end

  describe "hp" do
    let(:character) { FactoryGirl.create :sword_world_rpg2_with_skills }
    subject { character.hp }

    context "level 3" do
      it { should eq (3 * 3 + character.hp_bonus + character.vitality) }
    end

    context "level 5" do
      before do
        character.acquired_skills << FactoryGirl.build(:sword_world_rpg2_acquired_skill, :level => 5)
      end
      it { should eq (5 * 3 + character.hp_bonus + character.vitality) }
    end

    context "level 5 with bonus 15" do
      before do
        character.acquired_skills << FactoryGirl.build(:sword_world_rpg2_acquired_skill, :level => 5)
        character.hp_bonus = 15
      end
      it { should eq (5 * 3 + 15 + character.vitality) }
    end
  end

  describe "mp" do
    let(:character) { FactoryGirl.create :sword_world_rpg2_with_skills }
    let(:mp_skill) { FactoryGirl.create :sword_world_rpg2_skill, has_mp: true }
    subject { character.mp }

    context "not have mp" do
      it { should eq character.mind }
    end

    context "level 3 magician" do
      before do
        character.acquired_skills << FactoryGirl.build(:sword_world_rpg2_acquired_skill, skill: mp_skill)
      end
      it { should eq (character.mind + 3 * 3) }
    end

    context "level 3 magican and level 2 priest" do
      before do
        character.acquired_skills << FactoryGirl.build(:sword_world_rpg2_acquired_skill, skill: mp_skill)
        character.acquired_skills << FactoryGirl.build(:sword_world_rpg2_acquired_skill, skill: mp_skill, level: 2)
      end
      it { should eq (character.mind + 5 * 3) }
    end
  end
end
