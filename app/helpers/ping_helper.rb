module PingHelper
def ping
	@machine = Machine.find_by_id(params[:machine_id])
	if @machine.nil?
			render :text => "La machines n'&eacute;xiste pas"
	else
		  if Ping.pingecho(@machine.ip_machine, 2, 'echo')
			render :text => "1"
			@machine.etat_machine='1'
			@machine.save!
			puts "Reply from @machine.ip_machine"
		  else
			render :text => "0"
			@machine.etat_machine='0'
			@machine.save!
			puts "@machine.ip_machine timed out"
		  end
	end
end
end
