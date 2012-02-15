# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :room do
    title 'Room 1'
    description 'this is test room.'
    user
  end
end
