require 'spec_helper'

describe Importer do
  describe "#run" do
    before  { @source = Rails.root.join('spec', 'fixtures', 'test.csv') }
    before  { @importer = Importer.new }
    subject { @importer.run(@source) }
    it      { should be_a Hash }
    specify { subject[:failures].should == 1 }
    specify { subject[:successes].should == 5 }
    specify { subject[:errors].should == [["Url is invalid"]] }
  end
end