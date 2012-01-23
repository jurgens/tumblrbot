require 'spec_helper'

describe SettingsController do
  describe "changing status" do
    before { Settings.should_receive(:status=).with('on') }
    specify do
      post :status, status: 'on'
      respond_with :success
    end
  end
end