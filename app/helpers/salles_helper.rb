module SallesHelper
	#nbre de machine dans une salle
	def nbremachine(salleid)
		begin
			@nbmac = Machine.find(:all, :conditions =>{:salle_id => salleid.to_i})	
			return @nbre = @nbmac.count
		rescue 
			Logger.debug "Probleme"
		end
		
	end
end
