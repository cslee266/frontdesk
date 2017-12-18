class VisitorsController < ApplicationController
	before_action :find_visitor, only: [:update, :destroy]

	def create
		@visitor = Visitor.new(visitor_params)
		if @visitor.save
			redirect_to current_user
		else
			render :new
		end
	end

	def new
		@visitor = Visitor.new
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
	end

	private

	def find_user
		@visitor = Visitor.find(params[:id])
	end

	def visitor_params
		params.require(:visitor).permit(:name, :visit_day, :arrival_time)
	end
end
