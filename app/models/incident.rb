class Incident < ActiveRecord::Base
	
	attr_accessible :date_resolution_incident, :statut_incident, :niveau_incident, :description_incident, :proprietes_supplementaires
	
	belongs_to :machine

end
