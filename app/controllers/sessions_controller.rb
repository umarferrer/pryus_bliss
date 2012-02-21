class SessionsController < ApplicationController

	def new
		@titre = "Identification"
	end

	def create
		user = Administrateur.authentifier(params[:sessions][:login_mail],params[:sessions][:password])
		if user.nil?
			@titre = "Identification"
			flash.now[:error] = "Votre pseudo ou votre mot de passe est incorrect"
			render 'new'
		else
			sign_in user
			redirect_to root_path
		end
	end

	def destroy
		sign_out
    	redirect_to root_path
	end

end
