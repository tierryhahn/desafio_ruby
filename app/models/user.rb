require 'rotp'

class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Devise::Models

  field :name, type: String
  field :email, type: String
  field :unipile_email_account_id, type: String
  field :unipile_linkedin_account_id, type: String
  field :otp_secret, type: String
  field :encrypted_password, type: String


  validates :email, presence: true
  validates :password, presence: true
  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  def generate_otp_secret
    self.otp_secret = ROTP::Base32.random_base32
  end

  def otp
    @otp ||= ROTP::TOTP.new(otp_secret)
  end

  def generate_otp_token
    otp.now
  end

  def verify_otp(token)
    otp = ROTP::TOTP.new(otp_secret)
    otp.verify(token)
  end  
end
