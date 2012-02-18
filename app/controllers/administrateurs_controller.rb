require 'mail'
class AdministrateursController < ApplicationController
  # GET /administrateurs
  # GET /administrateurs.json


  def send_password
    @titre="Password recovery"
  end

  def forgot_password
    user = Administrateur.find_by_login_mail(params[:email])
	
	if (user) 

		user.reset_password_code_until = 1.day.from_now
		user.reset_password_code =  Digest::SHA1.hexdigest( "#{user.login_mail}--#{Time.now.utc}" )
		user.save!
	#	mail=Notifier.welcome().deliver





  mail = Mail.new do
  from 'ferrer.umar@gmail.com'
  to 'assatoc@gmail.com'
  subject  'Here is the image you wanted'
  body     "hey"#File.read('body.txt')

end

mail.deliver!












		flash[:succes] = "Ok"
		redirect_to root_path
	else
		flash[:error] = "Ok"
		redirect_to root_path
	end 

  end

	def reset_password
		user = Administrateur.find_by_reset_password_code(params[:reset_code])
		if user &&  user.reset_password_code_until  && Time.now < user.reset_password_code_until 
      cookies.permanent.signed[:remember_token] = [user.id, user.salt]
      self.current_user = user 
    end
		redirect_to root_path
	end
 
 
 
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
