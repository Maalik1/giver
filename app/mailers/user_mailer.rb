class UserMailer < ActionMailer::Base
  default from: Settings.contact[:from]
  
  def new_donor_email(email, password)
    @email     = email
    @password  = password

    mail(to: @email, subject: 'Welcome to Giver')
  end
end
