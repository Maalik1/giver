# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :reward do
    project
    amount { Faker::Commerce.price }
    description { Faker::Lorem.paragraph }
  end
end
