class SettingsController < ApplicationController
  def update
    @settings = Settings.instance

    if @settings.update_attributes params[:settings]
      respond_to do |format|
        format.html do
          flash[:notice] = 'Settings were successfully updated'
          redirect_to :back
        end
        format.js do
          render nothing: true
        end
      end
    else
      respond_to do |format|
        format.html do
          flash[:error] = 'Settings were not updated'
          redirect_to :back
        end
        format.js do
          render nothing: true
        end
      end
    end
  end

  #def status
  #  Settings.status = params[:status]
  #  render :nothing => true
  #end
end