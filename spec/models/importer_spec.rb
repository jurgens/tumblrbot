require 'spec_helper'

describe Importer do
  describe "#run" do
    before  { @source = Rails.root.join('spec', 'fixtures', 'test.csv') }
    before  { @importer = Importer.new }
    subject { @importer.run(@source) }
    it      { should be_a Hash }
    specify { subject[:successes].should == 5 }
    specify { subject[:failures].should == 2 }
    specify { subject[:errors].length.should == 2 }
  end
end