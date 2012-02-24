require 'faker'

namespace :db do
	desc "Peupler la base de donnee"

	task :peupler=> :environment do
		Rake::Task['db:reset'].invoke

		administrateur=Administrateur.create!(:nom_admin => "FERRER",
			:prenom_admin => "Umar",
			:login_mail => "root@gmail.com",
			:password => "root",
			:password_confirmation => "root")
		administrateur.save!

		administrateur=Administrateur.create!(:nom_admin => "FERRER",
			:prenom_admin => "Umar",
			:login_mail => "admin@gmail.com",
			:password => "admin",
			:password_confirmation => "admin")
		administrateur.save!
	

		salle=Salle.create!(:nom_salle => "Salle 1",
			:ip_reseau => "192.168.1.0",
			:masque_reseau => "255.255.255.0")
		salle.save!

			machine=salle.machines.create!(:nom_machine => "PC 1:1",
				:etat_machine => "1",
				:etat_service_machine => "1",
				:ip_machine => "127.0.0.1",
				:description_machine => "La machine a toto")

					5.times do |i|
						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "#{i+30}",
						:proprietes_supplementaires => "Memory")

						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "#{i+50}",
						:proprietes_supplementaires => "Cpu")

						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "Injoignable",
						:proprietes_supplementaires => "Ping")
					end	
					
	


			machine=salle.machines.create!(:nom_machine => "PC 1:2",
				:etat_machine => "1",
				:etat_service_machine => "1",
				:ip_machine => "127.0.0.1",
				:description_machine => "La machine a toto")

					5.times do |i|
						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "#{i+30}",
						:proprietes_supplementaires => "Memory")

						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "#{i+50}",
						:proprietes_supplementaires => "Cpu")

						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "Injoignable",
						:proprietes_supplementaires => "Ping")
					end	

			machine=salle.machines.create!(:nom_machine => "PC 1:3",
				:etat_machine => "1",
				:etat_service_machine => "1",
				:ip_machine => "127.0.0.1",
				:description_machine => "La machine a toto")
					
					5.times do |i|
						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "#{i+30}",
						:proprietes_supplementaires => "Memory")

						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "#{i+50}",
						:proprietes_supplementaires => "Cpu")

						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "Injoignable",
						:proprietes_supplementaires => "Ping")
					end	







		salle=Salle.create!(:nom_salle => "Salle 2",
			:ip_reseau => "192.168.2.0",
			:masque_reseau => "255.255.255.0")
		salle.save!

			machine=salle.machines.create!(:nom_machine => "PC 2:1",
				:etat_machine => "1",
				:etat_service_machine => "1",
				:ip_machine => "192.168.2.1",
				:description_machine => "La machine a toto")

					5.times do |i|
						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "#{i+30}",
						:proprietes_supplementaires => "Memory")

						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "#{i+50}",
						:proprietes_supplementaires => "Cpu")

						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "Injoignable",
						:proprietes_supplementaires => "Ping")
					end	

			machine=salle.machines.create!(:nom_machine => "PC 2:2",
				:etat_machine => "1",
				:etat_service_machine => "1",
				:ip_machine => "192.168.2.2",
				:description_machine => "La machine a toto")

					5.times do |i|
						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "#{i+30}",
						:proprietes_supplementaires => "Memory")

						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "#{i+50}",
						:proprietes_supplementaires => "Cpu")

						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "Injoignable",
						:proprietes_supplementaires => "Ping")
					end	







		salle=Salle.create!(:nom_salle => "Salle 3",
			:ip_reseau => "192.168.3.0",
			:masque_reseau => "255.255.255.0")
		salle.save!
		
			machine=salle.machines.create!(:nom_machine => "PC 3:1",
				:etat_machine => "1",
				:etat_service_machine => "1",
				:ip_machine => "192.168.3.1",
				:description_machine => "La machine a toto")

					5.times do |i|
						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "#{i+30}",
						:proprietes_supplementaires => "Memory")

						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "#{i+50}",
						:proprietes_supplementaires => "Cpu")

						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "Injoignable",
						:proprietes_supplementaires => "Ping")
					end	

			machine=salle.machines.create!(:nom_machine => "PC 3:2",
				:etat_machine => "1",
				:etat_service_machine => "1",
				:ip_machine => "192.168.3.2",
				:description_machine => "La machine a toto")

					5.times do |i|
						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "#{i+30}",
						:proprietes_supplementaires => "Memory")

						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "#{i+50}",
						:proprietes_supplementaires => "Cpu")

						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "Injoignable",
						:proprietes_supplementaires => "Ping")
					end	







		salle=Salle.create!(:nom_salle => "Salle 4",
			:ip_reseau => "192.168.4.0",
			:masque_reseau => "255.255.255.0")
		salle.save!
			
			machine=salle.machines.create!(:nom_machine => "PC 4:1",
				:etat_machine => "1",
				:etat_service_machine => "1",
				:ip_machine => "192.168.4.1",
				:description_machine => "La machine a toto")

					5.times do |i|
						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "#{i+30}",
						:proprietes_supplementaires => "Memory")

						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "#{i+50}",
						:proprietes_supplementaires => "Cpu")

						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "Injoignable",
						:proprietes_supplementaires => "Ping")
					end	

			machine=salle.machines.create!(:nom_machine => "PC 4:2",
				:etat_machine => "1",
				:etat_service_machine => "1",
				:ip_machine => "192.168.4.2",
				:description_machine => "La machine a toto")

					5.times do |i|
						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "#{i+30}",
						:proprietes_supplementaires => "Memory")

						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "#{i+50}",
						:proprietes_supplementaires => "Cpu")

						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "Injoignable",
						:proprietes_supplementaires => "Ping")
					end	

			machine=salle.machines.create!(:nom_machine => "PC 4:3",
				:etat_machine => "1",
				:etat_service_machine => "1",
				:ip_machine => "192.168.4.1",
				:description_machine => "La machine a toto")

					5.times do |i|
						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "#{i+30}",
						:proprietes_supplementaires => "Memory")

						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "#{i+50}",
						:proprietes_supplementaires => "Cpu")

						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "Injoignable",
						:proprietes_supplementaires => "Ping")
					end	

			machine=salle.machines.create!(:nom_machine => "PC 4:3",
				:etat_machine => "1",
				:etat_service_machine => "1",
				:ip_machine => "192.168.4.1",
				:description_machine => "La machine a toto")

					5.times do |i|
						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "#{i+30}",
						:proprietes_supplementaires => "Memory")

						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "#{i+50}",
						:proprietes_supplementaires => "Cpu")

						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "Injoignable",
						:proprietes_supplementaires => "Ping")
					end	

			machine=salle.machines.create!(:nom_machine => "PC 4:4",
				:etat_machine => "1",
				:etat_service_machine => "1",
				:ip_machine => "192.168.4.4",
				:description_machine => "La machine a toto")

					5.times do |i|
						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "#{i+30}",
						:proprietes_supplementaires => "Memory")

						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "#{i+50}",
						:proprietes_supplementaires => "Cpu")

						machine.incidents.create!(:date_resolution_incident => Time.now,
						:statut_incident => "1",
						:niveau_incident => "C",
						:description_incident => "Injoignable",
						:proprietes_supplementaires => "Ping")
					end	








		salle=Salle.create!(:nom_salle => "Salle 5",
			:ip_reseau => "192.168.5.0",
			:masque_reseau => "255.255.255.0")
		salle.save!

			

	end
end