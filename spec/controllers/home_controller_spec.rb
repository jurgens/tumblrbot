require 'spec_helper'

describe HomeController do
  describe "index" do
    it { assigns[:authentication] }
    it { assigns[:counters] }
  end

  describe "upload" do
    before do
      @file = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'test.csv'), 'text/csv')
      @importer = mock(:importer)
      @importer.should_receive(:run).with(@file.path).and_return({successes: 5, failures: 1})
      Importer.stub(:new).and_return(@importer)
    end

    specify do
      post :upload, file: @file
      response.should redirect_to root_url
      should set_the_flash.to(:notice => "Added 5 new jobs, 1 failed to add")
    end
  end
end
