class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	validates :username, :email, :password, :password_confirmation, presence: true
  #  has_secure_password
	has_many :measurements, dependent: :destroy
	has_one :goal
end
