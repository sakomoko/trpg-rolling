# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :game_system_name do |n|
    "TestGameSystem#{n}"
  end

  factory :game_system do
    name {FactoryGirl.generate :game_system_name}
    description "MyString"
    system_key { name }
  end
end
