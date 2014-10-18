# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link do
    org
    location { Faker::Internet.url }
  end
end
