class PagesController < ApplicationController

	def index
		@titre="Index"
		@salles=Salle.all
		@i=0
	end

	def machine_historique

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
