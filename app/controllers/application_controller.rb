class ApplicationController < ActionController::Base
	protect_from_forgery
	include SessionsHelper

	def default_url_options
		if Rails.env.production?  
			{:host => "pryusbliss.heroku.com"}
		else 
			{:host => "localhost:3000"}		
		end
	end

end
