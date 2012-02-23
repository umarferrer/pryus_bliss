class MachinesController < ApplicationController
require 'ping' 
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
		
		@salles.nbre_machine = @salles.nbre_machine + 1
		@salles.update_attributes(params[:nbre_machine])
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
	@salles.nbre_machine = @salles.nbre_machine - 1
	@salles.update_attributes(params[:nbre_machine])
    @machine.destroy
	
    respond_to do |format|
      format.html { redirect_to machines_url }
      format.json { head :ok }
    end
  end
  
  #before_filter :authenticate, :only => [:create , :new, :update, :destroy]
  
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
def all_ping
	@machine = Machine.all
	@machine.each do |mach|
		if Ping.pingecho(mach.ip_machine, 2, 'echo')
			mach.etat_machine='1'
			mach.save!
		else
			mach.etat_machine='0'
			mach.save!
		end
	end
end
end

