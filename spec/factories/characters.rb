# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :character do
    name "Character"
    age 17
    gender :female
    user
    game_system
    world
  end
end
