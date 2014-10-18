# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :donation do
    user
    project
    reward
    amount { Faker::Commerce.price }
  end
end
