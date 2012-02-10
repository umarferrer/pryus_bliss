class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.integer :id_machine_incident
      t.string :date_incident
      t.string :date_resolution_incident
      t.string :statut_incident
      t.string :niveau_incident
      t.string :description_incident
      t.string :proprietes_supplementaires

      t.timestamps
    end
  end
end
