class User < ActiveRecord::Base
  validates :email, :password_digest, presence: true
  validates :email, uniqueness: true
  validates :activated, inclusion: { in: [true, false] }
  validates :activation_token, uniqueness: { allow_nil: true }
  
  after_initialize :set_activated_to_false, :set_unique_activation_token
  
  has_many :sign_ins, inverse_of: :user
  has_many :notes, inverse_of: :user, dependent: :destroy
  
  def self.find_by_credentials(credentials)
    return nil unless user = User.find_by_email(credentials["email"])
    user.is_password?(credentials["password"]) ? user : nil
  end
  
  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def activate_with_token(token)
    self.activated = true if self.activation_token == token
    self.activated
  end
  
  private
  def set_activated_to_false
    self.activated = false
  end
  
  def set_unique_activation_token
    loop do
      token = SecureRandom.urlsafe_base64
      return self.activation_token = token if token_unique?(token)
    end
  end
  
  def token_unique?(token)
    User.find_by_activation_token(token).nil?
  end
end
