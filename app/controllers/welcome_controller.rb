class WelcomeController < ApplicationController
  def index
    @user = current_user
    session[:conversations] ||= []
 
    # @users = User.all.where.not(id: current_user)


    if current_user
	    if current_user.role == "superadmin"
	    	@users = User.all.where.not(id: current_user)
	    	@conversations = Conversation.includes(:recipient, :messages)
                 			 .find(session[:conversations])
	    elsif current_user.role == "homeowner"
	    	@admin = User.find_by(role: "superadmin")
	    	@conversations = Conversation.get(current_user.id, @admin.id)
	    end
	end

  end
end

