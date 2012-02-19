class ApplicationController < ActionController::Base
	protect_from_forgery
	include SessionsHelper


	if Rails.env.production?  

		Rails.application.routes.default_url_options[:host]= 'pryusbliss.heroku.com'

	else 

		Rails.application.routes.default_url_options[:host]= 'localhost:3000'

	end

end
