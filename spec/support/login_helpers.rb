module LoginHelpers

  def login_as(role)
    if role == 'admin'
      cred = FactoryGirl.create(:cred)
      @user = cred.user
    elsif role == 'site_admin'
      @user = FactoryGirl.create(:site_admin)
    elsif role == 'user'
      @user = FactoryGirl.create(:user)
    end
    
    login_with(@user)
  end

  def login_with(user)
    visit new_user_session_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_button "Log in"
    Thread.current[:current_user] = user
  end
  
  def logout
    click_link 'Logout'
  end

end