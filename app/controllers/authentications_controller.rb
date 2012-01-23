class AuthenticationsController < ApplicationController
  def index
    @authentications = Authentication.all
  end

  def create
    auth = request.env["omniauth.auth"]
    @authentication = Authentication.create_with_omniauth(auth)

    flash[:notice] = "Authentication successful."
    redirect_to root_url
  end

  def destroy
    @authentication = Authentication.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to root_url
  end
end
