class Notifier < ActionMailer::Base

	#default_url_options[:host] = RAILS_ENV != production ?
     #      "http://localhost:3000/" : "http://pryusbliss.heroku.com/"

     #default_url_options[:host]="localhost:3000"
	default :from => "pryusbliss@gmail.com"
	def send_token(user)
		mail(:to => "#{user.nom_admin.upcase} #{user.prenom_admin.downcase.capitalize} <#{user.login_mail}>", :subject => "Vous avez demande un nouveau mot de passe Pryus (Bliss)", :body => "Bonjour #{user.prenom_admin.downcase.capitalize},

Vous avez demande la reinitialisation de votre mot de passe Pryus (Bliss).
 
Pour finaliser votre demande, veuillez cliquer sur ce lien:
#{change_password_request_url}?reset_code=#{user.reset_password_code} " )
	end

end
