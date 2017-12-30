class Api::MeasurementsController < ApplicationController

	before_action :set_user, only: [:index, :create]

	def index
		render json: @user.measurements, status: 200
	end

	def create
		@measurement = @user.measurements.build(measurement_params)
		if @measurement.save
			render json: @measurement, status: 201
		else
			render_errors_in_json
		end
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

	def measurement_params
		params.require(:measurement).permit(:systolic_bp, :diastolic_bp, :pulse, :date_time, :notes)
	end

	def render_errors_in_json
		render json: { 
			errors: { 
				messages: @measurement.errors.messages 
			}
		}, status: 422
	end
end