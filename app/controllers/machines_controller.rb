class MachinesController < ApplicationController
require 'ping' 
  before_filter :authenticate, :only => [:update_machine , :new_incident, :update_incident]
  # GET /machines
  # GET /machines.json
  def index
    @machines = Machine.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @machines }
    end
  end

  # GET /machines/1
  # GET /machines/1.json
  def show
    @machine = Machine.find(params[:id])

    machine_id = params[:id]
  mac = Machine.find machine_id
  @salles = Salle.find mac.salle_id
    #@Salles = Salle.find(:all, :conditions =>{:salle_id => Salle.find(params[:id])})

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @machine }
    end
  end
  def ping
	@machine = Machine.find_by_id(params[:machine_id])
	if @machine.nil?
			render :text => "La machines n'&eacute;xiste pas"
	else
		  if Ping.pingecho(@machine.ip_machine, 2, 'echo')
			render :text => "1"
			@machine.etat_machine=1
			@machine.save!
		  else
			render :text => "0"
			@machine.etat_machine=0
			@machine.save!
		  end
	end
end

def all_ping
	@machine = Machine.all
	@machine.each do |mach|
		if Ping.pingecho(mach.ip_machine, 2, 'echo')
			mach.etat_machine=1
			mach.save!
			r = Random.new
			chart = Charts.new
			chart.idmachine = mach.id
			chart.delay = r.rand(0..200)
			chart.save!
		else
			mach.etat_machine=0
			chart = Charts.new
			chart.idmachine = mach.id
			chart.delay = 0
			chart.save!
			mach.save!
		end
	end
end

  # GET /machines/new
  # GET /machines/new.json
  def new
    @machine = Machine.new
    @salles = Salle.all
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @machine }
    end
  end

  # GET /machines/1/edit
  def edit
    @machine = Machine.find(params[:id])
    @salles = Salle.all
  end

  # POST /machines
  # POST /machines.json
  def create
    @machine = Machine.new(params[:machine])
	@salles = Salle.find(params[:machine][:salle_id])
	@machine.etat_machine='1'
	@machine.etat_service_machine='1'
	

    respond_to do |format|
      if @machine.save
        format.html { redirect_to @machine, notice: 'Machine was successfully created.' }
        format.json { render json: @machine, status: :created, location: @machine }
		
		#@salles.nbre_machine = @salles.nbre_machine + 1
		#@salles.update_attributes(params[:nbre_machine])
      else
        format.html { render action: "new" }
        format.json { render json: @machine.errors, status: :unprocessable_entity }
      end
    end
	
  end

  # PUT /machines/1
  # PUT /machines/1.json
  def update
    @machine = Machine.find(params[:id])

    respond_to do |format|
      if @machine.update_attributes(params[:machine])
        format.html { redirect_to @machine, notice: 'Machine was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @machine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /machines/1
  # DELETE /machines/1.json
  def destroy
    @machine = Machine.find(params[:id])
	@salles = Salle.find @machine.salle_id
	#@salles.nbre_machine = @salles.nbre_machine - 1
	#@salles.update_attributes(params[:nbre_machine])
    @machine.destroy
	
    respond_to do |format|
      format.html { redirect_to machines_url }
      format.json { head :ok }
    end
  end

  def update_machine
    @machine=Machine.find_by_id(params[:id])
    if @machine.nil?
      render :status => 500
    else
      if !Salle.find_by_id(params[:salle]).nil?
        @machine.update_attributes!(:salle_id => params[:salle])
        render :inline => "ajaxok"
      else
        render :inline => "404salle"
      end
    end
  end

  def new_incident 
	params[:description]=params[:description].tr("_", " ")
	@machine=Machine.find_by_id(params[:machine_id])
	if @machine.nil?
		 render :status => 500
	else
		# if  = ping
		if params[:ping_service] == "1"
			# if deja probleme de ping
			if @machine.etat_machine == "0"
				render :inline => "already"
			elsif @machine.etat_machine == "1"
				@machine.update_attributes!(:etat_machine => "0")
				@machine.incidents.create!(:statut_incident => "0",
				:niveau_incident=> "C",
			 	:description_incident => params[:description],
			 	:proprietes_supplementaires => params[:propriete])
			 	render :inline => "ajaxok"
			else
				render :status => 500
			end			
		# if = service[memory or cpu]
		elsif params[:ping_service] == "2"
			# if deja un probleme ?
			if @machine.etat_service_machine == "0"
				# met a jour la valeur de la ram ou cpu
				@inci=@machine.incidents.find_by_statut_incident_and_proprietes_supplementaires("0",params[:propriete])
				if !@inci.nil?
					@inci.update_attributes!(:description_incident => params[:description], :niveau_incident => params[:niveau])
					render :inline => "ajaxok"				
				# exemple : on cree W en ram et on le passe en C, ensuite on va sur cpu et on veut le passe en W ou C marchera pas
				elsif @inci.nil? 
					render :inline => "already"
				end
			# Si nouveau pas de probleme avant
			elsif @machine.etat_service_machine == "1"
				@machine.update_attributes!(:etat_service_machine => "0")
				@machine.incidents.create!(:statut_incident => "0",
				:niveau_incident=> params[:niveau],
			 	:description_incident => params[:description],
			 	:proprietes_supplementaires => params[:propriete])
			 	render :inline => "ajaxok"
			else
				render :status => 500
			end			
		else
			render :status => 500			
		end
	end
  end

  def get_incident
  	@machine=Machine.find_by_id(params[:machine_id])
	if @machine.nil?
		render :status => 500
	else
		@inci=@machine.incidents.find_by_statut_incident_and_proprietes_supplementaires("0",params[:ping_service])
		if @inci.nil?
			render :inline => "none"
		else
			render :inline => @inci.description_incident
		end
	end
  end

  def update_incident
  	@machine=Machine.find_by_id(params[:machine_id])
	if @machine.nil?
		render :status => 500
	else
		if params[:ping_service] == "Ping"
			@machine.update_attributes!(:etat_machine => "1")
		elsif params[:ping_service] == "Memory"
			@machine.update_attributes!(:etat_service_machine => "1")
		elsif params[:ping_service] == "Cpu"
			@machine.update_attributes!(:etat_service_machine => "1")
		end
		@inci=@machine.incidents.find_by_statut_incident_and_proprietes_supplementaires("0",params[:ping_service])
		if @inci.nil?
			render :inline => "none"
		else
			@inci.update_attributes!(:date_resolution_incident => Time.now, :statut_incident => "1" )
			render :inline => "ajaxok"
		end
	end
  end

  def etat_machine
  	@machine=Machine.find_by_id(params[:machine_id])
	if @machine.nil?
		render :status => 500
	else
		render :inline => "#{@machine.etat_machine}+#{@machine.etat_service_machine}"
	end
  end
end

