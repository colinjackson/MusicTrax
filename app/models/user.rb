class User < ActiveRecord::Base
  validates :email, :password_digest, presence: true
  validates :email, uniqueness: true
  
  has_many :sign_ins, inverse_of: :user
  
  def self.find_by_credentials(credentials)
    user = User.find_by_email(credentials[:email])
    user.is_password?(credentials[:password])
  end
  
  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end
end
