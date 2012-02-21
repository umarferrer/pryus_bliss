class JsController < ApplicationController
def view
    end
    def data
        @administrateurs = Administrateur.all
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
                user.nom_admin = "nom_admin"
                user.prenom_admin = "prenom_admin"
                user.login_mail = "login_mail@gmail.com"
                user.password = "admin"
                user.password_confirmation = user.password
                user.save!
               
                @tid = user.id
            when "deleted"
                user=Administrateur.find(@id)
                user.destroy
               
                @tid = @id
            when "updated"
                if nom_admin!='' and prenom_admin != '' and login_mail!= '' and  hached_password != ''
                    user=Administrateur.find(@id)
                    user.nom_admin = nom_admin
                    user.prenom_admin = prenom_admin
                    user.login_mail = login_mail
                    user.password = hached_password
                    user.password_confirmation = user.password
                    user.save!                   
                end
                @tid = @id
        end
    end
end