module SallesHelper
	#nbre de machine dans une salle
	def nbremachine(id_salle_machine)
		#begin
			@nbmac = Machine.find(:all, :conditions =>{:id_salle_machine => id_salle_machine.to_i})	
			
		#rescue 
		#	Logger.debug "Probleme"
			
		#end
		
		return @nbre = @nbmac.count
	end
end
