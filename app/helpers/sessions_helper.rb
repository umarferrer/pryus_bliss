module SessionsHelper

	def sign_in(user)
		cookies.permanent.signed[:remember_token] = [user.id, user.salt]
		self.current_user = user
	end

	def current_user=(user)
		@current_user = user
	end

	def signed_in?
		!current_user.nil?
	end

	def current_user
		@current_user ||= user_from_remember_token
	end

	def current_user?(user)
		user == current_user
	end

	def sign_out
		cookies.delete(:remember_token)
		self.current_user=nil
	end

	def authenticate
		deny_access unless signed_in?
	end

	def deny_access
		create_pwd
		flash[:succes]="Identifier vous !"
		redirect_to signin_path
	end

	def redirect_to_pwd
		redirect_to(session[:pwd] || root_path )
		clear_pwd
	end

	def even?(number)
		return true if (number % 2) == 0
	end

	def evenn?(number)
		return true if (number % 2) == 0
	end

	private

		def user_from_remember_token
			Administrateur.authenticate_with_salt(*remember_token)
		end

		def remember_token
			cookies.signed[:remember_token] || [nil, nil]
		end

		def create_pwd
			session[:pwd] = request.fullpath
		end

		def clear_pwd
			session[:pwd] = nil
		end
end
