class SessionsController < ApplicationController


   def new
  end


    def create
    log_out
    user = Usuario.find_by(nombre: params[:session][:usuario])
    if user
      # Log the user in and redirect to the user's show page.
	#log_in user
	log_in user
	redirect_to root_url
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
