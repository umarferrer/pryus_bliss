class Machine < ActiveRecord::Base
  belongs_to :salle
  has_many :incidents, :dependent => :destroy

  attr_accessible :nom_machine
  attr_accessible :ip_machine
  attr_accessible :salle_id
  attr_accessible :nom_salle
  attr_accessible :description_machine
  attr_accessible :date_crea_machine
  attr_accessible :etat_machine
  attr_accessible :etat_service_machine
  #validates_presence_of :id_salle_machine
  #validates_uniqueness_of :id_salle_machine
  
  validates :nom_machine, :presence => true
  validates :ip_machine, :presence => true
  validates :description_machine, :presence => true
  validates :salle_id, :presence => true
  
   #fonctions statistiques
    def self.mtbf_machine
      # nbre_incident = Salle.Machine.incidents.count
      #@mtbf =
     
    end
    def self.mttr_machine
      # nb = find_by_sql("select SUM((date_resolution_incident) - ( created_at)) as ta, count(*) as na from incidents where machine_id =#{machine}") 
      # return Time.at(nb).day
    end
    #maintenabilite
    def maint_salle
      return @fiab = 1/@mtbf.to_i
    end
    #disponibilite
    def dispo_salle
      return @dispo = @mtbf.to_i/(@mtbf.to_i + @mttr.to_i)
    end
    #fiabilite
    def fiab_salle
      return @fiab = 1/@mttr.to_i
    end

end
