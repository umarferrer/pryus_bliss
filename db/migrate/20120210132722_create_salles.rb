class CreateSalles < ActiveRecord::Migration
  def change
    create_table :salles do |t|
      t.string :nom_salle
      t.string :ip_reseau
      t.string :masque_reseau
      t.int :nbre_machine

      t.timestamps
    end
  end
end
