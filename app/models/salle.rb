class Salle < ActiveRecord::Base
	attr_accessible :nom_salle, :ip_reseau, :masque_reseau, :nbre_machine
	
	has_many :machines
end
