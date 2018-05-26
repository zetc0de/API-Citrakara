class User < ApplicationRecord
	has_secure_password
validates :username, uniqueness: true , length: { in: 1..10 }
validates :email, uniqueness: true 
validates :password, presence: true , allow_nil: true


end
