class UserMailer < ActionMailer::Base
  default from: "yourfriends@localhost3000.com"
  
  def activation_email(user)
    @user, @url = user, user.url
  end
end
