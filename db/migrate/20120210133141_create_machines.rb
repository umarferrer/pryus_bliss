class CreateMachines < ActiveRecord::Migration
  def change
    create_table :machines do |t|
      t.string :nom_machine
      t.string :ip_machine
      t.int :id_salle_machine
      t.string :description_machine
      t.string :date_crea_machine
      t.string :etat_machine
      t.string :etat_service_machine

      t.timestamps
    end
  end
end
