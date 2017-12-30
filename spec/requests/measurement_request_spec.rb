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

				let(:valid_params) {
					{
						measurement: {
							user_id: user_id,
							systolic_bp: 125,
							diastolic_bp: 70,
							pulse: 85,
							date_time: Faker::Time.between(2.days.ago, Date.today, :day),
							notes: Faker::Lorem.sentence
						}
					}
				}

				before { post "/api/users/#{user_id}/measurements", params: valid_params }

				it 'returns a status code of 201' do
					expect(response).to have_http_status(201)
				end

				it "returns the user's new measurement in JSON" do
					expect(json).not_to be_empty
					expect(json[:id]).not_to eq(nil)
					expect(json[:systolic_bp]).not_to eq(nil)
					expect(json[:diastolic_bp]).not_to eq(nil)
					expect(json[:pulse]).not_to eq(nil)
					expect(json[:date_time]).not_to eq(nil)
				end
			end

			context 'if params are invalid' do

				let(:invalid_params) {
					{
						measurement: {
							user_id: '',
							systolic_bp: '',
							diastolic_bp: '',
							pulse: '',
							date_time: '',
							notes: ''
						}
					}
				}
				before { post "/api/users/#{user_id}/measurements", params: invalid_params}
				
				it 'returns a status code of 422' do
					expect(response).to have_http_status(422)
				end

				it 'returns the validation error messages in JSON' do
					expect(json).not_to be_empty
					expect(json[:errors][:messages]).to eq({
	 					:systolic_bp=>["can't be blank"],
	 					:diastolic_bp=>["can't be blank"],
	 					:pulse=>["can't be blank"],
	 					:date_time=>["can't be blank"]
	 					})
				end

			end
		end

		context 'if user does not exist' do

			before { post "/api/users/10000/measurements" }

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