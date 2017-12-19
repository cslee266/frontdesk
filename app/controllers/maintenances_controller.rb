class MaintenancesController < ApplicationController
	before_action :find_user, only: [:new, :edit, :index]
	before_action :find_maintenance, only: [:update, :destroy]

	def create
		@maintenance = current_user.maintenances.new(maintenance_params)
		@user = current_user
		if @maintenance.save
			flash[:success] = "Maintenance request successfully raised!"
			redirect_to maintenances_path
		else
			redirect_to new_maintenances_path
		end
	end

	def new
		@maintenance = Maintenance.new
	end

	def update
		@maintenance = Maintenance.update(maintenance_params)
		if @maintenance.save
			redirect_to current_user
		else
			render :new
		end
	end

	def destroy
		@maintenance.destroy
		redirect_to current_user
	end

	def index
		@maintenances = Maintenance.all
	end

	private

	def find_user
		@user = current_user
	end

	def find_maintenance
		@maintenance = Maintenance.find(params[:id])
	end

	def maintenance_params
		params.require(:maintenance).permit(:title, :description)
	end
end
