class VisitorsController < ApplicationController
	before_action :find_user, only: [:new, :edit]
	before_action :find_visitor, only: [:update, :destroy]

	def create
		@visitor = current_user.visitors.new(visitor_params)
		@user = current_user
		if @visitor.save
			flash[:success] = "Visitor successfully registered!"
			redirect_to user_visitors_path(current_user.id)
		else
			redirect_to new_user_visitor_path(current_user.id)
		end
	end

	def new
		@visitor = Visitor.new
		@user = current_user
	end

	def update
		@visitor = Visitor.update(visitor_params)
		if @visitor.save
			redirect_to current_user
		else
			render :new
		end
	end

	def destroy
		@visitor.destroy
		redirect_to current_user
	end

	def index
		@visitors = Visitor.all
		@user = current_user
	end

	private

	def find_user
		@user = current_user
	end

	def find_visitor
		@visitor = Visitor.find(params[:id])
	end

	def visitor_params
		params.require(:visitor).permit(:name, :visit_day, :arrival_time, :car_plate)
	end
end
