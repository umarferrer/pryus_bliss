class SallesController < ApplicationController
  # GET /salles
  # GET /salles.json
  def index
    @salles = Salle.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @salles }
    end
  end

  # GET /salles/1
  # GET /salles/1.json
  def show
    @salle = Salle.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @salle }
    end
  end

  # GET /salles/new
  # GET /salles/new.json
  def new
    @salle = Salle.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @salle }
    end
  end

  # GET /salles/1/edit
  def edit
    @salle = Salle.find(params[:id])
  end

  # POST /salles
  # POST /salles.json
  def create
    @salle = Salle.new(params[:salle])

    respond_to do |format|
      if @salle.save
        format.html { redirect_to @salle, notice: 'Salle was successfully created.' }
        format.json { render json: @salle, status: :created, location: @salle }
      else
        format.html { render action: "new" }
        format.json { render json: @salle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /salles/1
  # PUT /salles/1.json
  def update
    @salle = Salle.find(params[:id])

    respond_to do |format|
      if @salle.update_attributes(params[:salle])
        format.html { redirect_to @salle, notice: 'Salle was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @salle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /salles/1
  # DELETE /salles/1.json
  def destroy
    @salle = Salle.find(params[:id])
    @salle.destroy

    respond_to do |format|
      format.html { redirect_to salles_url }
      format.json { head :ok }
    end
  end
end
