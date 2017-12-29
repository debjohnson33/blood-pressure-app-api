require 'rails_helper'

RSpec.describe 'Users API', type: :request do
	
	#Initial Test Data
	let!(:users) { FactoryBot.create_list(:user, 5)}
	let(:user_id) { users.first.id}

	# GET /api/users
	describe 'GET /api/users' do
		
		before { get '/api/users' }

		it 'returns a status code of 200' do
			expect(response).to have_http_status(200)
		end

		it 'returns a collection of users in JSON' do

			expect(json).not_to be_empty
			expect(json.size).to eq(5)
		end
	end
	# POST /api/users (new user)

	describe 'POST /api/users' do

		context 'when the request is valid' do

			let(:valid_params) {
				{
					user: {
						username: Faker::Internet.user_name,
					    email: Faker::Internet.safe_email,
					    password: "password",
					    password_confirmation: "password" 
					}
				}
			}
			before { post '/api/users', params: valid_params }

			it 'returns a status code of 201' do
				expect(response).to have_http_status(201)
			end

			it 'creates a user and returns it in JSON' do

				expect(json).not_to be_empty
				expect(json[:id]).not_to eq(nil)
				expect(json[:first_name]).to eq(valid_params[:user][:first_name])
				expect(json[:last_name]).to eq(valid_params[:user][:last_name])
				expect(json[:gender]).to eq(valid_params[:user][:gender])
				expect(json[:birthdate]).to eq(valid_params[:user][:birthdate])
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

		# GET /api/users/:id
	describe 'GET /api/users/:id' do

		context 'if user exists' do
			
			before { get "/api/users/#{user_id}" }

			it 'returns a status code of 200' do
				expect(response).to have_http_status(200)
			end

			it 'returns a user in JSON' do

				expect(json).not_to be_empty
				expect(json[:id]).to eq(user_id)
				expect(json[:first_name]).to eq(users.first.first_name)
				expect(json[:last_name]).to eq(users.first.last_name)
				expect(json[:gender]).to eq(users.first.gender)
				expect(json[:birthdate]).to eq("1989-03-02T00:00:00.000Z")
			end

		end

		context 'if user does not exist' do
			
			before { get "/api/users/1000" }

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
	
	# PUT /api/user/:id

	describe 'PUT /api/users/:id' do
		
		describe 'if user exists' do
			
			context 'and has valid params' do

				let(:valid_params) {
					{
						user: {
							first_name: "Updated first name", 
		    				last_name: "Updated last name",
		    				gender: "Updated gender",
		    				birthdate: "1980-03-02T00:00:00.000Z"
						}
					}
				}

				before { put "/api/users/#{user_id}", params: valid_params}

				it 'updates the user' do
					expect(json[:first_name]).to eq(valid_params[:user][:first_name])
					expect(json[:last_name]).to eq(valid_params[:user][:last_name])
					expect(json[:gender]).to eq(valid_params[:user][:gender])
					expect(json[:birthdate]).to eq(valid_params[:user][:birthdate])

				end

				it 'returns a status code of 200' do
					expect(response).to have_http_status(200)
				end
			end

			context 'and has invalid params' do

				let(:invalid_params) {
					{
						user: {
							first_name: "", 
		    				last_name: "",
		    				gender: "",
		    				birthdate: ""
						}
					}
				}

				before { put "/api/users/#{user_id}", params: invalid_params}

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

		context 'if user does not exist' do

			before { put "/api/users/10000"}

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
	# DELETE /api/users/:id

	describe 'DELETE /api/users/:id' do
		
	end

end