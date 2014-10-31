# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    user
    project
    body { Faker::Lorem.paragraph }
  end
end