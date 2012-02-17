# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :world do
    name "MyString"
    description "MyString"
    game_system
    association :owner, factory: :user
  end
end
