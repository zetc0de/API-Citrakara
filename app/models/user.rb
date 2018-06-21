class User < ApplicationRecord
	has_secure_password
	has_many :paintings
	has_many :favorite_paintings
	has_many :favorites, through: :favorite_paintings, source: :painting
	has_many :comments
	has_many :feedbacks

	attr_accessor :current_password

	validates :username, uniqueness: true, length: { in: 1..10 }
	validates :password, presence: true, allow_nil: true
	validates :email, uniqueness: true
end
