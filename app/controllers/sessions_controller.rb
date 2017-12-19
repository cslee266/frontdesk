class SessionsController < Clearance::SessionsController
	def create_from_omniauth
	  auth_hash = request.env["omniauth.auth"]
	  authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) ||  Authentication.create_with_omniauth(auth_hash)

	  # if: previously already logged in with OAuth
	  if authentication.user
	    user = authentication.user
	    authentication.update_token(auth_hash)
	    @next = root_path
	    @notice = "Signed in!"
	  # else: user logs in with OAuth for the first time
	  else
	    user = User.create_with_auth_and_hash(authentication, auth_hash)
	    # you are expected to have a path that leads to a page for editing user details
	    @next = edit_user_path(user)
	    @notice = "User created. Please confirm or edit details"
	  end

	  sign_in(user)
	  redirect_to @next, :notice => @notice
	end


	def destroy
		sign_out 
		redirect_to root_path
	end
end