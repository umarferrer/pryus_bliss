class Machine < ActiveRecord::Base
  belongs_to :salle
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
  

end
