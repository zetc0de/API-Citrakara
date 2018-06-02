class User < ApplicationRecord
	has_secure_password
	has_many :paintings
	has_many :comments

	validates :username, uniqueness: true, length: { in: 1..10 }
	validates :password, presence: true, allow_nil: true
	validates :email, uniqueness: true
end
