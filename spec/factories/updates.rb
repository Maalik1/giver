# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :update do
    project
    content { Faker::Lorem.paragraph }
  end
end
