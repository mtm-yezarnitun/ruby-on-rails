class UserMailer < ApplicationMailer
  default from: 'no-reply@yourapp.com'

  def welcome_email(user, raw_password = nil)
    @user = user
    @password = raw_password 
    @url  = 'http://localhost:3000'
    mail(to: @user.email, subject: 'Welcome to My Awesome App')
  end
end
