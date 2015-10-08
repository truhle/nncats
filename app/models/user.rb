

class User < ActiveRecord::Base

  attr_accessor :password

  has_many :cats
  has_many :cat_rental_requests
  has_many :user_sessions

  # after_initialize :set_session_token!, if: :new_record?

  validates :user_name, :password_digest, presence: true
  validates :user_name, uniqueness: true

  def destroy_this_session!(session_token)
    this_session = user_sessions.find_by(session_token: session_token)
    this_session.destroy
  end

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def set_session_token!
    session_token = SecureRandom.urlsafe_base64
    this_session = user_sessions.create(session_token: session_token)
  end

  def set_session_attributes(options)
    this_session = options[:session]
    attributes = options[:attributes]
    this_session.update(browser: attributes[:browser], device: attributes[:device], os: attributes[:os])
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
