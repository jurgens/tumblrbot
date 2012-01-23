require 'spec_helper'

describe Settings do
  describe "status" do
    before { Settings.status = 'on' }
    specify { Settings.status.should == 'on' }
  end
end
