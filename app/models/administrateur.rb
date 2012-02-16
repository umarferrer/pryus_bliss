class Administrateur < ActiveRecord::Base
	
	attr_accessible :login_mail, :hached_password

	def bon_mdp?(mdp)
		hached_password == mdp
	end

	def self.authentifier(email, mdp)
		user = find_by_login_mail(email)		
		return nil if user.nil? or !user.bon_mdp?(mdp)
		return user 		
	end

end