require 'rails_helper'

RSpec.describe User, type: :model do
	
	context "validations" do
		
		it { should validate_presence_of(:first_name)}
		it { should validate_presence_of(:last_name)}
		it { should validate_presence_of(:gender)}
		it { should validate_presence_of(:birthdate)}
	end
end