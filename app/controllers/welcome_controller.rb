class WelcomeController < ApplicationController
  def index
    @user = current_user
    @new_user = User.new
  end

  def features
    @user = current_user
    @new_user = User.new
  end
end

