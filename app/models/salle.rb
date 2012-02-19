class Salle < ActiveRecord::Base
	has_many :machines
	validates_uniqueness_of :nom_salle
	validates_presence_of :nom_salle ,:ip_reseau, :masque_reseau, {:message =>"Ce champ est obligatoire"}
	
	#vérification que 12 chiffres sont saisis
	validates_format_of :masque_reseau , :ip_reseau, {:with =>/\d{3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/, :message => "Le format doit etre xxx xxx xxx xxx"}
 	
 	attr_accessible :nom_salle, :masque_reseau, :ip_reseau , :id_salle
  	#attr_accessible  :id_salle
  
	#s'assurer d'avoir une salle vide avant de la supprimer
	#before_destroy :vider_salle
	def vider_salle
		#if nbre_machine(self.Salle.id_salle).to_i == 0

	end
end