class Administrateur < ActiveRecord::Base
	
	attr_accessible :login_mail, :hached_password

	attr_accessor :password
	attr_accessible :nom_admin, :prenom_admin, :login_mail, :password

	before_save :encrypt_password

	def bon_mdp?(mdp)
		if self.hached_password == encrypt(mdp)
			return true
		else
			return false
		end
	end

	def self.authentifier(email, mdp_soumis)
		user = find_by_login_mail(email)		
		if user.nil? 
			return nil
		end

		if user.bon_mdp?(mdp_soumis)
			return user 
		else
			return nil		
		end
	end

	def self.authenticate_with_salt(id, cookie_salt)
			user = find_by_id(id)
			if !user.nil? and ( user.salt == cookie_salt )
				return user
			else
				return nil
			end
	end

	private

		def encrypt_password
			self.salt=make_salt if new_record?
			self.hached_password = encrypt(password)
		end

		def encrypt(string)
			secure_hach("#{salt}--#{string}")
		end

		def make_salt
			secure_hach("#{Time.now.utc}--#{password}")
		end

		def secure_hach(string)
			Digest::SHA2.hexdigest(string)
		end


end