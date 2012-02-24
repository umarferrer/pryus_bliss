class PagesController < ApplicationController

    before_filter :authenticate, :only => [:incidents, :admin]
    
	def index
		@titre="Index"
		@salles=Salle.all
		@i=0
	end

	def machine_historique
		@titre="Detaille d'une machine"
		@machine=Machine.find_by_id(params[:id_machine])
		if !@machine.nil?
			@salles=Salle.all
		else
			render :inline => "pasok"
		end
	end

	def update_menu
		@salles=Salle.all
		render 'pages/_index_menu.html.erb', :layout => false
	end

    def incidents
        @salles=Salle.all
    end

    def admin

    end

	def view
    end
    
    def data
        @users = User.all()
    end
	def chart
        #@events = Events.all()
    end
    def dbaction
        #called for all db actions
		rank = params["c0"]
        first_name = params["c1"]
        last_name    = params["c2"]
        pass  = params["c3"]
       
        @mode = params["!nativeeditor_status"]
       
        @id = params["gr_id"]
        case @mode
            when "inserted"
                user = User.new
                user.rank = rank
				user.first_name = first_name
                user.last_name = last_name
                user.pass = pass
                user.save!
               
                @tid = user.id
            when "deleted"
                user=User.find(@id)
                user.destroy
               
                @tid = @id
            when "updated"
                user=User.find(@id)
                user.rank = rank
				user.first_name = first_name
                user.last_name = last_name
                user.pass = pass
                user.save!
               
                @tid = @id
        end
    end

end
