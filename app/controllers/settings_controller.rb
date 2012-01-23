class SettingsController < ApplicationController
  def status
    Settings.status = params[:status]
    render :nothing => true
  end
end