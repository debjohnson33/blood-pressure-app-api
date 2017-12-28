class User < ApplicationRecord
	has_many :measurements, dependent: :destroy
	has_one :goal
	validates :first_name, :last_name, :gender, :birthdate, presence: true
end
