require 'rails_helper'

RSpec.describe 'Measurements API', type: :request do
	
	let!(:user) { FactoryBot.create(:user)}
	let!(:measurements) { FactoryBot.create_list(:measurement, 5, user_id: user_id)}
	let(:user_id) { user.id}
	let(:measurement_id) { measurements.first.id }

	#GET /api/users/user_id/measurements

	describe 'GET /api/users/measurements' do
		
			context 'when user exists' do
				
				before(:each) {
					FactoryBot.create(:measurement, user_id: user_id)
				}

				before { get "/api/users/#{user_id}/measurements" }

				it 'returns a status code of 200' do
					expect(response).to have_http_status(200)
				end

				it "returns all of the user's measurements in JSON" do
					expect(json.size).to eq(6)
					expect(json[0][:id]).not_to eq(nil) 
				end
			end

			context 'if user does not exist' do

				before { get "/api/users/10000/measurements" }

				it 'returns a status code of 404' do
					expect(response).to have_http_status(404)
				end

				it 'returns error messages of not found in JSON' do
					expect(json).not_to be_empty
					expect(json[:errors][:messages]).to eq({
						:user=>"can't be found"})
				end
			end
	end


	# POST /api/user/user_id/measurements (new measurement)

	describe 'post /api/users/user_id/measurements' do

		describe 'when user exists' do

			context 'if params are valid' do

				before { post "/api/users/#{user_id}/measurements" }

				it 'returns a status code of 200' do
					expect(response).to have_http_status(200)
				end

				it "returns all of the user's measurements in JSON" do
					expect(json.size).to eq(6)
					expect(json[0][:id]).not_to eq(nil) 
				end
			end
		end

		context 'if user does not exist' do

			before { get "/api/users/10000/measurements" }

			it 'returns a status code of 404' do
				expect(response).to have_http_status(404)
			end

			it 'returns error messages of not found in JSON' do
				expect(json).not_to be_empty
				expect(json[:errors][:messages]).to eq({
					:user=>"can't be found"})
			end
		end

	end
	# GET /api/user/measurements/:id
	# PUT /api/user/measurements/:id
	# DELETE /api/user/measurements/:id


end