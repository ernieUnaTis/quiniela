class HomeController < ApplicationController

	def home
		if logged_in?
			puts "SESION"
			redirect_to "/home/home" 
		else
			puts "No SESION"
			redirect_to login_path
		end
	end


	def index
	end

end
