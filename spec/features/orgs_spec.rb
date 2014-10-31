require 'rails_helper'

feature 'Orgs' do
  
  describe 'Admin' do

    before do
      login_as('site_admin')
    end

    after do
      logout
    end 

    scenario 'Admin user adds new org' do
      visit new_org_path

      attach_file 'photo', "#{Rails.root}/spec/support/images/1x1.png"
      fill_in 'org_name', with: Faker::Company.name
      fill_in 'org_display_name', with: Faker::Company.name
      fill_in 'org_ein', with: Faker::Number.number(10)
      fill_in 'org_description', with: Faker::Lorem.paragraph
      fill_in 'org_mission', with: Faker::Lorem.paragraph
      fill_in 'org_location', with: Faker::Address.street_address
      check   'org_tax_exempt'
      click_button 'Submit'

      expect(page).to have_content('successfully created')
    end

  end

  describe 'User' do

    before do
      login_as('user')
    end

    after do
      logout
    end 

    scenario 'Basic user attempts to add org' do
      visit new_org_path
      expect(page).to have_content('not authorized')
    end

  end

end