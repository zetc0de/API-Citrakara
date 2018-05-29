class User < ApplicationRecord
	has_secure_password
	has_many :paintings
	has_many :feedbacks
	validates :username, uniqueness: true, length: { in: 1..10 }
	validates :password, presence: true
	validates :email, uniqueness: true
end
