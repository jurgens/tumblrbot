require 'spec_helper'

describe Settings do
  describe "status" do
    before { Settings.status = 'on' }
    specify { Settings.status.should == 'on' }
  end

  describe "getting detault status value" do
    specify { Settings.status.should be_nil }
  end

  describe "status?" do
    context "uninitialized" do
      specify { Settings.status?.should be_false }
    end

    context "on" do
      before { Settings.status = 'on' }
      specify { Settings.status?.should be_true }
    end

    context "off" do
      before { Settings.status = 'off' }
      specify { Settings.status?.should be_false }
    end
  end
end
