class SessionsController < ApplicationController

	def new
		@titre = "Identification"
	end

	def create
		user = Administrateur.authentifier(params[:sessions][:login_mail],params[:sessions][:password])

		if user.nil?
			@titre = "Identification"
			flash.now[:error] = "Combinaison Email/Mot de passe invalide."
			render 'new'
		else
			sign_in user
			redirect_to root_path
		end
	end

	def destroy
	end

end
