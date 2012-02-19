class JsController < ApplicationController
def view
    end
    def data
        @administrateurs = Administrateur.all
    end
	
	def secure_hach(string)
		Digest::SHA2.hexdigest(string)
	end
	def dbaction
        #called for all db actions
		nom_admin = params["c0"]
        prenom_admin = params["c1"]
        login_mail    = params["c2"]
        hached_password  = params["c3"]
        salt = params["c4"]
        @mode = params["!nativeeditor_status"]
       
        @id = params["gr_id"]
        case @mode
            when "inserted"
				@salt=secure_hach("#{Time.now.utc}--#{hached_password}")
                user = Administrateur.new
                user.nom_admin = nom_admin
				user.prenom_admin = prenom_admin
                user.login_mail = login_mail
                user.hached_password = secure_hach("#{@salt}--#{hached_password}")
                user.salt=@salt
				user.save!
               
                @tid = user.id
            when "deleted"
                user=Administrateur.find(@id)
                user.destroy
               
                @tid = @id
            when "updated"
                user=Administrateur.find(@id)
                user.nom_admin = nom_admin
				user.prenom_admin = prenom_admin
                user.login_mail = login_mail
                user.hached_password = secure_hach("#{user.salt}--#{hached_password}")
				user.save!
               
                @tid = @id
        end
    end
end
