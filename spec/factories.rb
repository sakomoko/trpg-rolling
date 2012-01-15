require 'factory_girl'
FactoryGirl.define do

  sequence :name do |n|
    "Test User#{n}"
  end

  sequence :email do |n|
    "person#{n}@example.com"
  end

  factory :user, :aliases => [:other_user] do
    name
    email
    password 'please'
  end

  factory :room do
    title 'Room 1'
    context 'this is test room.'
    user
  end
end
