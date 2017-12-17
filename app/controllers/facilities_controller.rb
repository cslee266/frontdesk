class FacilitiesController < ApplicationController
	def index
		@user = current_user
		@facility = Facility.all
		@reservation = Reservation.new
	end
end
