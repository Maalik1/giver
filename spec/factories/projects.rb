# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    org
    title { Faker::Commerce.product_name }
    story { Faker::Lorem.paragraphs(3) }
    starts "2015-01-01"
    ends "2015-10-01"
    goal { Faker::Commerce.price }
  end
end
