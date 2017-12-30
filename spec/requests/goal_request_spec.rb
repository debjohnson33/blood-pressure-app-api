require 'rails_helper'

RSpec.describe 'Goals API', type: :request do
	
	let!(:user) { FactoryBot.create(:user)}
	let!(:goal) { FactoryBot.create(:goal)}
	let(:user_id) { user.id}

#GET /api/users/user_id/goal

	describe 'GET /api/users/user_id/goal' do
		
		context 'when user exists' do

			before { get "/api/users/#{user_id}/goal" }

			it 'returns a status code of 200' do
				expect(response).to have_http_status(200)
			end

			it "returns the user's goal in JSON" do
				expect(json.size).to eq(1)
				expect(json[0][:id]).not_to eq(nil) 
			end
		end
	end
end