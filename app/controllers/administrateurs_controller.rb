class AdministrateursController < ApplicationController

  before_filter :authenticate, :only => :change_password_process

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



  def forgot_password
    @titre="Forgot password"
  end

  def new_password_request
    user = Administrateur.find_by_login_mail(params[:email])
    if (user)       
      user.update_attribute(:reset_password_code_until , 1.day.from_now )
      user.update_attribute(:reset_password_code , Digest::SHA2.hexdigest( "#{user.login_mail}--#{Time.now.utc}" ) )
      Notifier.send_token(Administrateur.first).deliver
      flash[:noti] = "Un mail vous a ete envoye. Il contient un lien que vous devrez visiter pour que votre mot de passe soit change"
      redirect_to root_path
    else
      @titre="Forgot password"
      flash.now[:error] = "Il n'y a pas de compte avec ce login"
      params[:email]=nil
      render 'forgot_password'
    end 
  end

  def change_password_request
    user = Administrateur.find_by_reset_password_code(params[:reset_code])
    if user &&  user.reset_password_code_until  && Time.now < user.reset_password_code_until 
      @erreurs= user
      sign_in(user)
      @titre="Change password request"    
    else
      flash[:error] = "Il n'y a pas de demande de changement de mot de passe avec ces parametres"
      redirect_to root_path
    end
  end

  def change_password_process
    user = Administrateur.find_by_reset_password_code(params[:changes][:token])
    if user && current_user?(user) && Time.now < user.reset_password_code_until 
      if user.update_attributes(:password => params[:changes][:password],:password_confirmation => params[:changes][:password_confirmation] )
        user.update_attribute(:reset_password_code_until , nil )
        user.update_attribute(:reset_password_code , nil )
        flash[:succes] = "Password changed !"
        redirect_to root_path
      else        
        @titre="Change password request"  
        @erreurs= user
        params[:reset_code]=params[:changes][:token]
        render 'change_password_request'
      end   
    else    
      flash[:error] = "Il n'y a pas de demande de changement de mot de passe avec ces parametres"
      redirect_to root_path
    end 
  end

end
