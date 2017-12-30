class User < ApplicationRecord

	validates :username, presence: true, uniqueness: true
	validates :email, presence: true, uniqueness: true 
	#validates :password, presence: true, length: { minimum: 8 }, on: :create
	has_secure_password
	has_many :measurements, dependent: :destroy
	has_one :goal
end
