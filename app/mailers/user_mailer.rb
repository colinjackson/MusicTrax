class UserMailer < ActionMailer::Base
  default from: "Me <yourfriends@localhost3000.com>"
  
  def activation_email(user)
    @user, @activation_url = user, generate_activation_url_for_user(user)
    mail(to: user.email, subject: 'Authenticate your new account')
  end
  
  private
  def generate_activation_url_for_user(user)
    default_url_options[:host] = '10.0.1.123:3000'
    "#{ activations_users_url }?activation_token=#{ user.activation_token }"
  end
end
