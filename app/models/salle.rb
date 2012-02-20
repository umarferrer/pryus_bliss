class Salle < ActiveRecord::Base
	has_many :machines
	validates_uniqueness_of :nom_salle , {:message =>"Ce nom de salle existe deja "}
	
	validates_presence_of :nom_salle ,:ip_reseau, :masque_reseau, {:message =>"Ce champ est obligatoire"}
	
	#vérification que 12 chiffres sont saisis
	validates_format_of :masque_reseau , :ip_reseau, {:with =>/\d{3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/, :message => "Le format doit etre xxx xxx xxx xxx"}
 	
 	attr_accessible :nom_salle, :masque_reseau, :ip_reseau , :id
  	attr_accessible  :id
 end