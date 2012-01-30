require 'spec_helper'

describe SettingsController do
  describe "updating settings" do
    before do
      settings = mock_model 'Settings'
      settings.should_receive(:update_attributes).and_return(true)
      Settings.should_receive(:instance).and_return(settings)
    end

    specify do
      post :update, format: :js, settings: { status: 'on', delay: '1-5' }
      respond_with :success
    end
  end
end