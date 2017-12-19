class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

  
  require 'open_weather' 

  require 'open-uri'

	url = 'https://newsapi.org/v2/top-headlines?'\
	      'sources=bbc-news&'\
	      'apiKey=ff5aca1a4edf4ee1ac56620366445fee'

	req = open(url)
	response_body = req.read
	puts response_body
end
