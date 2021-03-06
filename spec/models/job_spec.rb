require 'spec_helper'

describe Job do
  it { should validate_presence_of :url }
  it { should validate_uniqueness_of :url}
  it { should validate_inclusion_of(:status).to_allow(Job::STATUSES) }

  let(:job) { Factory :job }

  context "url is a required field" do
    before { @job = Job.new }
    specify { @job.should_not be_valid }
    specify { @job.should have(2).errors_on(:url) }
  end

  context "url should be a valid URL" do
      before { @job = Job.new url: 'some.string'}
      specify { @job.should_not be_valid }
      specify { @job.should have(1).errors_on(:url) }
    end

  context "new job gets PENDING status" do
    before { @job = Job.new url: 'http://some.url.com' }
    specify { @job.should be_valid }
    specify { @job.status.should == Job::PENDING }
  end

  context "`pending` scope should only return pending jobs" do
    before { @pending = Factory :job }
    before { @success = Factory :successful_job }
    before { @error   = Factory :failed_job }

    specify { Job.pending.should == [@pending] }
  end

  let(:job) { Factory :job }

  context "#success" do
    before { job.success }
    specify { job.status.should == Job::SUCCESS }
  end

  context "#error" do
    before { job.error('error message') }
    specify { job.status.should == Job::ERROR }
    specify { job.status_message.should == 'error message' }
  end

  describe "last_time" do
    context "with existing job" do
      before { @job = Factory :successful_job }
      before do
        Timecop.freeze(Date.today - 1.day) do
          @older_job = Factory :successful_job
        end
      end
      specify { Job.last_time.should == @job.processed_at }
    end

    context "with no jobs" do
      specify { Job.last_time.should == nil }
    end
  end

  describe ".clear" do
    before { Factory :job }
    specify do
      Job.clear
      Job.all.count.should == 0
    end
  end
end
