class Api::UsersController < ApplicationController
	def index
		users = User.all
		render json: users, status: 200
	end

	def create
		user = User.new(user_params)
		if user.save
			render json: user, status:201
		else
			render json: { 
				errors: { 
					messages: user.errors.messages 
				}
			}, status: 422
		end
	end

	def show
		user = User.find_by(id: params[:id])
		if user
			render json: user, status: 200
		else
			render json: {
				errors: {
					messages: { user: "can't be found"}
				}
			}, status: 404
		end
	end

	private

	def user_params
		params.require(:user).permit(:first_name, :last_name, :gender, :birthdate)
	end
end