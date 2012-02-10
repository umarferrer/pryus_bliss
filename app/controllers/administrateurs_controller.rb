class AdministrateursController < ApplicationController
  # GET /administrateurs
  # GET /administrateurs.json
  def index
    @administrateurs = Administrateur.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @administrateurs }
    end
  end

  # GET /administrateurs/1
  # GET /administrateurs/1.json
  def show
    @administrateur = Administrateur.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @administrateur }
    end
  end

  # GET /administrateurs/new
  # GET /administrateurs/new.json
  def new
    @administrateur = Administrateur.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @administrateur }
    end
  end

  # GET /administrateurs/1/edit
  def edit
    @administrateur = Administrateur.find(params[:id])
  end

  # POST /administrateurs
  # POST /administrateurs.json
  def create
    @administrateur = Administrateur.new(params[:administrateur])

    respond_to do |format|
      if @administrateur.save
        format.html { redirect_to @administrateur, notice: 'Administrateur was successfully created.' }
        format.json { render json: @administrateur, status: :created, location: @administrateur }
      else
        format.html { render action: "new" }
        format.json { render json: @administrateur.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /administrateurs/1
  # PUT /administrateurs/1.json
  def update
    @administrateur = Administrateur.find(params[:id])

    respond_to do |format|
      if @administrateur.update_attributes(params[:administrateur])
        format.html { redirect_to @administrateur, notice: 'Administrateur was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @administrateur.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /administrateurs/1
  # DELETE /administrateurs/1.json
  def destroy
    @administrateur = Administrateur.find(params[:id])
    @administrateur.destroy

    respond_to do |format|
      format.html { redirect_to administrateurs_url }
      format.json { head :ok }
    end
  end
end
