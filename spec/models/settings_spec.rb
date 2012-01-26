require 'spec_helper'

describe Settings do
  describe "status" do
    before { Settings.status = 'on' }
    specify { Settings.status.should == 'on' }
  end

  describe "getting detault status value" do
    specify { Settings.status.should be_nil }
  end
end
