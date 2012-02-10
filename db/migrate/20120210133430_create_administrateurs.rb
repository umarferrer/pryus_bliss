class CreateAdministrateurs < ActiveRecord::Migration
  def change
    create_table :administrateurs do |t|
      t.string :nom_admin
      t.string :prenom_admin
      t.string :login_mail
      t.string :hached_password
      t.string :salt

      t.timestamps
    end
  end
end
