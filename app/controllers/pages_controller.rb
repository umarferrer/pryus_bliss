class PagesController < ApplicationController

	def index
		@titre="Index"
		@salles=Salle.all
		@i=0
	end

	def machine_historique

	end

end
