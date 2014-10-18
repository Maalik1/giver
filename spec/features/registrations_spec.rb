require 'rails_helper'

feature "Registration" do
  scenario "First user registers as admin" do
    visit new_user_registration_path

    # fill_in 'user_org_name', with: Faker::Company.name
    fill_in 'user_name', with: Faker::Name.name
    fill_in 'user_email', with: Faker::Internet.email
    fill_in 'user_password', with: 'passward123'
    fill_in 'user_password_confirmation', with: 'passward123'
    click_button 'Create Account'

    expect(page).to have_http_status(:success)
  end
end