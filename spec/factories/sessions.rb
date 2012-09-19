# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :session do
    title "MyString"
    description "MyString"
    started_at { DateTime.now }
    finished_at { DateTime.now }
    association :game_master, factory: :user
    world
  end
end
