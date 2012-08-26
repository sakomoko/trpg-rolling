require 'spec_helper'

describe SwordWorldRpg2 do
  describe "attr_accesible" do
    it { should be_accessible :name }
    it { should be_accessible :sex }
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

    it { should_not be_accessible :user_id }
    it { should_not be_accessible :game_system_id }
    it { should_not be_accessible :world_id }
  end

  describe "status" do
    let(:character) { FactoryGirl.create :sword_world_rpg2 }
    subject { character }

    context "dexterity" do
      its(:dexterity) { should be_eql (character.technique + character.sub_a + character.grow_dexterity + character.dexterity_bonus) }
    end

    context "agility" do
      its(:agility) { should be_eql (character.technique + character.sub_b + character.grow_agility + character.agility_bonus) }
    end

    context "strength" do
      its(:strength) { should be_eql (character.physique + character.sub_c + character.grow_strength + character.strength_bonus) }
    end

    context "vitality" do
      its(:vitality) { should be_eql (character.physique + character.sub_d + character.grow_vitality + character.vitality_bonus) }
    end

    context "intelligence" do
      its(:intelligence) { should be_eql (character.heart + character.sub_e + character.grow_intelligence + character.intelligence_bonus) }
    end

    context "mind" do
      its(:mind) { should be_eql (character.heart + character.sub_f + character.grow_mind + character.mind_bonus) }
    end
  end
end