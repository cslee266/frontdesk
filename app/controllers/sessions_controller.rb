class SessionsController < Clearance::SessionsController
	if respond_to?(:before_action)
    before_action :redirect_signed_in_users, only: [:new]
    skip_before_action :require_login,
      only: [:create, :new, :destroy],
      raise: false
    skip_before_action :authorize,
      only: [:create, :new, :destroy],
      raise: false
  else
    before_filter :redirect_signed_in_users, only: [:new]
    skip_before_filter :require_login,
      only: [:create, :new, :destroy],
      raise: false
    skip_before_filter :authorize,
      only: [:create, :new, :destroy],
      raise: false
  end

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

  def create
    @user = authenticate(params)

    sign_in(@user) do |status|
      if status.success?
        redirect_back_or url_after_create
      else
        flash.now.notice = status.failure_message
        redirect_to root_path
      end
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end

  def new
    render template: "sessions/new"
  end

  private

  def redirect_signed_in_users
    if signed_in?
      redirect_to url_for_signed_in_users
    end
  end

  def url_after_create
    Clearance.configuration.redirect_url
  end

  def url_after_destroy
    sign_in_url
  end

  def url_for_signed_in_users
    url_after_create
  end
end