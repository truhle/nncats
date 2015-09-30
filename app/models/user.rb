

class User < ActiveRecord::Base

  attr_accessor :password

  has_many :cats

  after_initialize :reset_session_token!, if: :new_record?

  validates :user_name, :session_token, :password_digest, presence: true
  validates :user_name, :session_token, uniqueness: true

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token!
    update_attribute(:session_token, SecureRandom.urlsafe_base64)
  end

  def is_password?(password)
    recovered_digest = BCrypt::Password.new(password_digest)
    recovered_digest == password
  end

  def self.find_by_credentials(user_name, password)
    user = User.find_by(user_name: user_name)
    if user && user.is_password?(password)
      user
    end
  end


end
