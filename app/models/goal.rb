class Goal < ApplicationRecord
	validates :systolic_bp, :diastolic_bp, :frequency, :user_id, presence: true
	belongs_to :user
end
