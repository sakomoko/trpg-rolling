# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sword_world_rpg2_skill, :class => 'SwordWorldRpg2::Skill' do
    sequence(:name) {|n| "Skill#{n}" }
    has_mp false
  end
end
