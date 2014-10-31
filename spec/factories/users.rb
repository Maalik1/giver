# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    name  { Faker::Name.name }
    email { Faker::Internet.email }
    password 'passward123'
    password_confirmation { password }

    factory :site_admin do
      admin true
    end

    factory :admin_user do
      after(:create) do |user|
        user.orgs << FactoryGirl.create(:org)
      end
    end
  end
end
