class User < ActiveRecord::Base
  validates :email, :password_digest, presence: true
  validates :email, uniqueness: true
  validates :activated, :admin, inclusion: { in: [true, false] }
  validates :activation_token, uniqueness: { allow_nil: true }
  
  after_initialize :ensure_activation, :set_unique_activation_token
  
  has_many :sign_ins, inverse_of: :user
  has_many :notes, inverse_of: :user, dependent: :destroy
  
  def self.find_by_credentials(credentials)
    return nil unless user = User.find_by_email(credentials["email"])
    user.is_password?(credentials["password"]) ? user : nil
  end
  
  def self.activate_with_token(token)
    user = User.find_by_activation_token(token)
    unless !user
      user.activated = true
      user.activation_token = nil
    end
    
    user
  end
  
  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
  
  def admin?
    self.admin
  end
  
  private
  def ensure_activation
    unless self.activated
      self.activated = false
    end
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
