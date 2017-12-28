require 'rails_helper'

RSpec.describe Measurement, type: :model do
	
	context "validations" do
		
		it { should validate_presence_of(:user_id)}
		it { should validate_presence_of(:systolic_bp)}
		it { should validate_presence_of(:diastolic_bp)}
		it { should validate_presence_of(:pulse)}
		it { should validate_presence_of(:date_time)}
		it { should validate_presence_of(:notes)}
	end

	context "relationships" do
		it { should belong_to(:user) }
	end
end