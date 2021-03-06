class ReservationsController < ApplicationController
	before_action :find_facility, only: [:create, :update, :destroy]

	def create
		@reservation = current_user.reservations.new(reservation_params)
		@reservation.facility = @facility
		if @reservation.save
			# ReservationJob.perform_now(@reservation.user, @listing.user, @reservation.id)
			flash[:success] = 'Reservation was successfully created.'
			redirect_to facilities_path
		else
			render "facilities/index"
		end
	end

	def update
		@reservation = current_user.reservations.update(reservation_params)
		@reservation.facility = @facility
		if @reservation.save
			# ReservationJob.perform_now(@reservation.user, @listing.user, @reservation.id)
			redirect_to current_user, notice: 'Reservation was successfully updated.'
		else
			render "facilities/index"
		end
	end

	def destroy
		@reservation = Reservation.find(params[:id])
		@reservation.destroy
		redirect_to @reservation.user, notice: 'Reservation was successfully cancelled.'
	end

	def index
		@reservations = current_user.reservations
	end

	private

	def find_facility
		@facility = Facility.find(params[:facility])
	end

	def reservation_params
		params.require(:reservation).permit(:start_time, :end_time, :facility_id)
	end
end
