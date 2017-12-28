require 'rails_helper'

RSpec.describe 'Measurements API', type: :request do
	
	#Initial Test Data
	let!(:users) { FactoryBot.create_list(:user, 5)}

	# GET /api/users
	describe 'GET /api/users' do
		
		before { get '/api/users' }

		it 'returns a status code of 200' do
			expect(response).to have_http_status(200)
		end

		it 'returns a collection of users in JSON' do
			json = JSON.parse(response.body)

			expect(json).not_to be_empty
			expect(json.size).to eq(5)
		end
	end
	# POST /api/users (new measurement)

	describe 'POST /api/users' do

		context 'when the request is valid' do

			let(:valid_attributes) {
				{
					user: {
						first_name: Faker::Name.first_name, 
	    				last_name: Faker::Name.last_name,
	    				gender: Faker::Demographic.sex,
	    				birthdate: "1989-03-02T00:00:00.000Z"
					}
				}
			}
			before { post '/api/users', params: valid_attributes }

			it 'returns a status code of 201' do
				expect(response).to have_http_status(201)
			end

			it 'creates a user and returns it in JSON' do
				json = JSON.parse(response.body, symbolize_names: true)

				expect(json).not_to be_empty
				expect(json[:id]).not_to eq(nil)
				expect(json[:first_name]).to eq(valid_attributes[:user][:first_name])
				expect(json[:last_name]).to eq(valid_attributes[:user][:last_name])
				expect(json[:gender]).to eq(valid_attributes[:user][:gender])
				expect(json[:birthdate]).to eq(valid_attributes[:user][:birthdate])
			end
		end

		context 'when the request is invalid' do
			
			before { post '/api/users', params: {
					user: {
						first_name: '', last_name: '', gender: '', birthdate: ''
					}
			}}

			it 'returns a status code of 422' do 
				expect(response).to have_http_status(422)
			end

			it 'returns the validation error messages in JSON' do
				json = JSON.parse(response.body, symbolize_names: true)

				expect(json).not_to be_empty
				expect(json[:errors][:messages]).to eq({
					:first_name=>["can't be blank"],
 					:last_name=>["can't be blank"],
 					:gender=>["can't be blank"],
 					:birthdate=>["can't be blank"]})
			end
		end
	end
	# GET /api/user/:id
	# PUT /api/user/:id
	# DELETE /api/user/:id


end