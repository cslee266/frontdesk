class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception



  
  require 'open_weather' 

  require 'open-uri'

end
