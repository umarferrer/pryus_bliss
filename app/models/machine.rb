class Machine < ActiveRecord::Base
	belongs_to :salle

	validates_uniqueness_of :nom_machine, :ip_machine,  {:message =>"Ce champ est obligatoire"}
	validates_presence_of :nom_machine, :ip_machine, :id_salle_machine, {:message =>"Ce champ est obligatoire"}

	validates_presence_of :date_crea_machine , :etat_machine, :etat_service_machine , {:message =>"Ce champ est obligatoire"}

	attr_accessible :nom_machine, :ip_machine, :etat_machine, :etat_service_machine, :date_crea_machine, :description,
	validates_format_of :ip_machine, {:with =>/\d{3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/, :message => "Le format doit etre xxx xxx xxx xxx"}
	#validates_format_of :ip_machine, {:with =>/\d{3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/, :message => "Le format doit etre xxx xxx xxx xxx"}
	#validates_format_of :date_crea_machine, {:with =>/\d{2}\/\d{2}\/\d{4}/, :message => "Le format doit etre xx/xx/xx"}
end
