class Measurement < ApplicationRecord
	belongs_to :user
	validates :user_id, :systolic_bp, :diastolic_bp, :pulse, :date_time, presence: true
end
