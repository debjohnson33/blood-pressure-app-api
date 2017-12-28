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
	# POST /api/user (new measurement)
	# GET /api/user/:id
	# PUT /api/user/:id
	# DELETE /api/user/:id


end