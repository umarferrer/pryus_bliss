class PagesController < ApplicationController

	def index
		@titre="Index"
		@salles=Salle.all
	end

	def machine_historique

	end

end
