class Salle < ActiveRecord::Base
	has_many :machines

	validates_uniqueness_of :nom_salle , {:message =>"Ce nom de salle existe deja "}
	
	validates_presence_of :nom_salle ,:ip_reseau, :masque_reseau, {:message =>"Ce champ est obligatoire"}
	
	#vérification que 12 chiffres sont saisis
	validates_format_of :masque_reseau , :ip_reseau, {:with =>/\d{3}\.\d{1,3}\.\d{1,3}\.\d{1,3}/, :message => "Le format doit etre xxx xxx xxx xxx"}
 	
 	attr_accessible :nom_salle, :masque_reseau, :ip_reseau , :id , :nbre_machine
  	attr_accessible  :id

  	  #fonctions statistiques
      def mtbf_salle
        #nbre_incident = Salle.Machine.incidents.count
        #@mtbf =
       
      end
      def self.mttr_salle
          # nb = find_by_sql("select SUM((date_resolution_incident) - ( created_at)) , count(*) as na from incidents where machine_id IN (select id from machines where salle_id=1)")   
            return Time.at(nb).day
      end
      #maintenabilite
      def self.maint_salle
        return @fiab = 1/@mtbf.to_i
      end
      #disponibilite
      def self.dispo_salle
        return @dispo = @mtbf.to_i/(@mtbf.to_i + @mttr.to_i)
      end
      #fiabilite
      def self.fiab_salle
        return @fiab = 1/@mttr.to_i
      end

end
