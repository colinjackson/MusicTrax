class SignIn < ActiveRecord::Base
  validates :user, :session_token, presence: true
  # uncomment for safety > efficiency
  # validates :session_token, uniqueness: true 
  
  after_initialize :set_unique_session_token
  
  belongs_to :user, inverse_of: :sign_ins
  
  def ==(other)
    self.session_token == other.session_token
  end
  
  private
  def set_unique_session_token
    loop do
      token = SecureRandom.urlsafe_base64
      return self.session_token = token if token_unique?(token)
    end
  end
  
  def token_unique?(token)
    SignIn.find_by_session_token(token).nil?
  end
end
