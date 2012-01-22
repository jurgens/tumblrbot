class AuthenticationsController < ApplicationController
  def index
    @authentications = Authentication.all
  end

  def create
    auth = request.env["omniauth.auth"]
    @authentication = Authentication.create_with_omniauth(auth)

    puts " -- #{@authentication.inspect}"

    flash[:notice] = "Authentication successful."
    redirect_to authentications_url
  end

  def destroy
    @authentication = Authentication.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end
end
