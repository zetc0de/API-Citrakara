class User < ApplicationRecord
	acts_as_voter
	has_secure_password
	has_many :paintings
	has_many :favorite_paintings
	has_many :favorites, through: :favorite_paintings, source: :painting
	has_many :comments
	has_many :feedbacks
	has_many :notifications

	mount_uploader :avatar, ImagepathUploader

	attr_accessor :current_password

	validates :username, uniqueness: true, length: { in: 1..10 }
	validates :password, presence: true, allow_nil: true
	validates :email, uniqueness: true


	def generate_password_token!
		self.reset_password_token = generate_token
		self.reset_password_sent_at = Time.now.utc
		save!
	  end
	  
	  def password_token_valid?
		(self.reset_password_sent_at + 4.hours) > Time.now.utc
	  end
	  
	  def reset_password!(password)
		self.reset_password_token = nil
		self.password = password
		save!
	  end
	  
	  private
	  
	  def generate_token
		SecureRandom.hex(10)
	  end
end
