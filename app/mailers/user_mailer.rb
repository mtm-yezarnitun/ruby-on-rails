class UserMailer < ApplicationMailer
  default from: 'no-reply@yourapp.com'

  def welcome_email(user)
    @user = user
    @url  = 'http://localhost:3000/login' # or your login URL
    mail(to: @user.email, subject: 'Welcome to My Awesome App')
  end
end

