class MachinesController < ApplicationController

  before_filter :authenticate, :only => :update_machine
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
    @salles = Salle.all

    respond_to do |format|
      if @machine.save
        format.html { redirect_to @machine, notice: 'Machine was successfully created.' }
        format.json { render json: @machine, status: :created, location: @machine }
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
end
