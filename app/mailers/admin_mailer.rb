class AdminMailer < ApplicationMailer
  default from: 'vs.begni@gmail.com'

  def new_user_email(user)
    @user = user
    @url = 'http://localhost/admin/users'
    mail(to: @user.email, subject: 'Juru-Finance: A new user was registered')
  end
end
