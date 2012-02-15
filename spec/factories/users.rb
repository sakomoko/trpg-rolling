# Read about factories at http://github.com/thoughtbot/factory_girl

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

end
