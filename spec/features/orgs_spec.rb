require 'rails_helper'

feature 'Orgs' do
  
  describe 'Admin' do

    before do
      login_as('admin')
    end

    after do
      logout
    end 

    scenario 'Admin user adds additional org details' do
      visit edit_org_path(@user.orgs.first.slug)

      attach_file 'org_photo', "#{Rails.root}/spec/support/images/1x1.png"
      fill_in 'org_name', with: Faker::Company.name
      fill_in 'org_display_name', with: Faker::Company.name
      fill_in 'org_ein', with: Faker::Number.number(10)
      fill_in 'org_description', with: Faker::Lorem.paragraph
      fill_in 'org_mission', with: Faker::Lorem.paragraph
      fill_in 'org_location', with: Faker::Address.street_address
      check   'org_tax_exempt'
      click_button 'Submit'

      expect(page).to have_content('have been updated')
    end

    scenario 'Admin adds a link to org' do 
      visit new_org_link_path(@user.orgs.first)

      fill_in      'link_location', with: Faker::Internet.url
      fill_in      'link_name', with: Faker::Lorem.word
      fill_in      'link_brand', with: 'github'
      click_button 'Submit'

      expect(page).to have_content('created')
    end

  end

  scenario 'Basic user attempts to edit an org' do
    login_as('user')
    visit edit_org_path(1)
    expect(page).to have_content('Projects')
    logout
  end

end