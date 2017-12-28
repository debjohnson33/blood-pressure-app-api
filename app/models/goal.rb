class Goal < ApplicationRecord
	belongs_to :user
	validates :systolic_bp, :diastolic_bp, :frequency, :user_id, presence: true
end
