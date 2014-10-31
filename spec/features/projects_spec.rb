require 'rails_helper'

feature 'Projects' do
  
  describe 'Site admin' do

    before do
      login_as('site_admin')
    end

    after do
      logout
    end 

    scenario 'creates a project' do
      FactoryGirl.create(:org)

      visit new_project_path
      
      select_date  Time.now.strftime("%B %d %Y"),          from: 'project_starts'
      select_date  Time.now.tomorrow.strftime("%B %d %Y"), from: 'project_ends'

      fill_in      'project_title',      with: Faker::Commerce.product_name
      fill_in      'project_goal',       with: '6000.00'
      attach_file  'photo',              "#{Rails.root}/spec/support/images/1x1.png"
      fill_in      'project_video',      with: Faker::Internet.url
      fill_in      'project_blurb',      with: Faker::Lorem.characters(200)
      fill_in      'project_location',   with: Faker::Address.zip
      fill_in      'project_story',      with: Faker::Lorem.paragraph
      fill_in      'project_challenges', with: Faker::Lorem.paragraph
      click_button 'Create Project'

      expect(page).to have_content('successfully created')
    end

  end

  describe 'Basic user' do

    before do
      login_as('user')
    end

    after do
      logout
    end 

    scenario 'tries to creates a project' do
      visit new_project_path
      expect(page).to have_content('not authorized')
    end

  end

end