# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :session do
    title "MyString"
    description "MyString"
    association :game_master, factory: :user
    world
  end
end
