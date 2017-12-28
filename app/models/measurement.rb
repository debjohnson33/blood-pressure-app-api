class Measurement < ApplicationRecord
	validates :user_id, :systolic_bp, :diastolic_bp, :pulse, :date_time, :notes, presence: true
	belongs_to :user
end
