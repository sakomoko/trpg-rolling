# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sword_world_rpg2 do
    race "Human"
    birth "Mercenary"
    pollution 0
    race_bonus ["divine protection"]
    records ["Records1", "Records2", "Record3"]
    level 2
    experience 3000
    total_experience 4500
    honor 10
    total_honor 10
    hp_bonus 15
    mp_bonus 0
    technique 7
    heart 4
    physique 10
    sub_a 11
    sub_b 6
    sub_c 7
    sub_d 8
    sub_e 4
    sub_f 7
    grow_dexterity 1
    grow_agility 0
    grow_strength 0
    grow_vitality 0
    grow_intelligence 0
    grow_mind 0
    dexterity_bonus 0
    agility_bonus 0
    strength_bonus 1
    vitality_bonus 0
    intelligence_bonus 0
    mind_bonus 0
  end
end
