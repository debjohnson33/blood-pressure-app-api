class Api::UsersController < ApplicationController
	def index
		users = User.all
		render json: users, status: 200
	end

	def create
		user = User.new(user_params)
		if user.save
			render json: user, status:201
		end
	end

	private

	def user_params
		params.require(:user).permit(:first_name, :last_name, :gender, :birthdate)
	end
end