class Api::MeasurementsController < ApplicationController

	before_action :set_user, only: [:index]

	def index
		render json: @user.measurements, status: 200
	end


	private

	def set_user
		@user = User.find_by(id: params[:user_id])
		if !@user
			render json: {
				errors: {
					messages: { user: "can't be found"}
				}
			}, status: 404
		end
	end
end