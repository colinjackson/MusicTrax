class SignIn < ActiveRecord::Base
  validates :user, :session_token, presence: true
  validates :session_token, uniqueness: true
  
  after_initialize :set_unique_session_token
  
  belongs_to :user, inverse_of: :sign_ins
  
  private
  def set_unique_session_token
    loop do
      token = SecureRandom.urlsafe_base64
      return self.session_token = token if token_unique?(token)
    end
  end
  
  def token_unique?(token)
    SignIn.where(session_token: token).empty?
  end
end
