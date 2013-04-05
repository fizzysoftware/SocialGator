class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :username, :post_times_attributes,:country,:dob,:timezone,:old_password,:name
  attr_accessor :password,:remember_me,:old_password,:password_confirmation,:update_password
  has_secure_password
  
  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :email, format: { with: valid_email_regex }
  validates :email, uniqueness: true
  validates :password, length: { within: 6..50 }, on: :create
  
  before_save :create_remember_token
  after_create :welcome_mail

  # associations
  has_many :businesses, dependent: :destroy
  has_many :facebook_pages, dependent: :destroy
  
  def to_param
    "#{id}-#{username.gsub(/[^a-z0-9]+/i, '-')}"
  end

  def welcome_mail
    UserMailer.welcome_message(self).deliver      
  end

  # Encrypts the password into the password_digest attribute.
  def password=(unencrypted_password)
    @password = unencrypted_password
    unless unencrypted_password.blank?
      self.password_digest = BCrypt::Password.create(unencrypted_password)
    end
  end

  def send_password_reset
    self.password_reset_token = SecureRandom.urlsafe_base64
    self.password_reset_sent_at = Time.now
    self.save!
    UserMailer.password_reset(self).deliver
  end

  
    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end

    def old_password_match
    expected_password = User.encrypted_password(old_password, self.password_digest)
    if self.hashed_password != expected_password
      errors.add(:base,"Old Password is invalid.")
      return false
    else
      return true
    end
  end

  handle_asynchronously :welcome_mail, :priority => 1
      
end