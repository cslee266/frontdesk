class UsersController < Clearance::UsersController
	# before_action :require_login
	before_action :find_user, only: [:show, :edit, :update]

	def edit
	end

	def show
		@user = current_user
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			redirect_to root_path
		else
			render 'edit'
		end
	end

	private
	def find_user
		@user = User.find(params[:id])
	end

	def user_params
		params.require(:user).permit(:email, :name, :password, :avatar)
	end
end
