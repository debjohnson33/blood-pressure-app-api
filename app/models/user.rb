class User < ApplicationRecord
	validates :first_name, :last_name, :gender, :birthdate, presence: true
	has_many :measurements
end
