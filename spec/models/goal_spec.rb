require 'rails_helper'

RSpec.describe Goal, type: :model do
	
	context "validations" do
		
		it { should validate_presence_of(:user_id)}
		it { should validate_presence_of(:systolic_bp)}
		it { should validate_presence_of(:diastolic_bp)}
		it { should validate_presence_of(:frequency)}
	end

	context "relationships" do
		it { should belong_to(:user) }
	end
end