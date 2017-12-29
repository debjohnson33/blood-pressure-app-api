class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	has_many :measurements, dependent: :destroy
	has_one :goal
	validates :first_name, :last_name, :gender, :birthdate, presence: true
end
