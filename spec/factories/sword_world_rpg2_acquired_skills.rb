# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sword_world_rpg2_acquired_skill, :class => 'SwordWorldRpg2::AcquiredSkill' do
    level 3
    association :skill, factory: :sword_world_rpg2_skill
  end
end
