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
						username: "nancy",
					    email: "nancy@example.com",
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
				expect(json[:username]).to eq(valid_params[:user][:username])
				expect(json[:email]).to eq(valid_params[:user][:email])
				expect(json[:password]).to eq(valid_params[:user][:password])
				expect(json[:password_confirmation]).to eq(valid_params[:user][:password_confirmation])
			end
		end

		context 'when the request is invalid' do
			
			before { post '/api/users', params: {
					user: {
						username: '', email: '', password: '', password_confirmation: ''
					}
			}}

			it 'returns a status code of 422' do 
				expect(response).to have_http_status(422)
			end

			it 'returns the validation error messages in JSON' do

				expect(json).not_to be_empty
				expect(json[:errors][:messages]).to eq({
					:username=>["can't be blank"],
 					:email=>["can't be blank"],
 					:password=>["can't be blank", "is too short (minimum is 8 characters)"],
 					:password_confirmation=>["can't be blank", "is too short (minimum is 8 characters)"]})
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
				expect(json[:username]).to eq(users.first.username)
				expect(json[:email]).to eq(users.first.email)
				expect(json[:password]).to eq(users.first.password)
				expect(json[:password_confirmation]).to eq(users.first.password_confirmation)
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
							username: "Updated first name", 
		    				email: "Updated last name",
		    				password: "Updated password",
		    				password_confirmation: "Updated password"
						}
					}
				}

				before { put "/api/users/#{user_id}", params: valid_params}

				it 'updates the user' do
					expect(json[:username]).to eq(valid_params[:user][:username])
					expect(json[:email]).to eq(valid_params[:user][:email])
					expect(json[:password]).to eq(valid_params[:user][:password])
					expect(json[:password_confirmation]).to eq(valid_params[:user][:password_confirmation])

				end

				it 'returns a status code of 200' do
					expect(response).to have_http_status(200)
				end
			end

			context 'and has invalid params' do

				let(:invalid_params) {
					{
						user: {
							username: "", 
		    				email: "",
		    				password: "",
		    				password_confirmation: ""
						}
					}
				}

				before { put "/api/users/#{user_id}", params: invalid_params}

				it 'returns a status code of 422' do 
					expect(response).to have_http_status(422)
				end

				it 'returns the validation error messages in JSON' do

					expect(json).not_to be_empty
					expect(json[:errors][:messages]).to eq({
						:username=>["can't be blank"],
	 					:email=>["can't be blank"],
	 					#:password=>["can't be blank", "is too short (minimum is 8 characters)"],
	 					#:password_confirmation=>["can't be blank", "is too short (minimum is 8 characters)"
	 					})
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
		
		context 'if user exists' do

			before { delete "/api/users/#{user_id}"}

			it 'returns a status code 204' do
				expect(response).to have_http_status(204)
			end
		end

		context 'if user does not exist' do

			before { delete "/api/users/10000"}

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

end