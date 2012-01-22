require 'spec_helper'

describe Worker do
  let(:worker) { Worker.new }
  let!(:authentication) { Factory :authentication }

  let(:job) { Factory :job }

  context "process a job" do
    before { Tumblr.stub(:follow).and_return(true) }
    specify { worker.process(job).should be_true }
    specify "it should change job status" do
      worker.process(job)
      job.status.should == Job::SUCCESS
    end
  end

  context "processing a job and fail" do
    before { Tumblr.stub(:follow).and_raise(RuntimeError.new('error message')) }
    specify "should change job status" do
      worker.process(job)
      job.status.should == Job::ERROR
      job.status_message.should == 'error message'
    end
  end

  context "should not try to process a job with status other than pending" do
    before { @successful_job = Factory :successful_job }
    before { Tumblr.should_not_receive(:follow) }
    specify { worker.process(@successful_job) }
  end

  describe "#run" do
    #before { Tumblr.stub(:follow).and_return(true) }
    before { @successful_job = Factory :successful_job }
    before { @pending = Factory :job }

    context "should not process pending job" do
      before { Tumblr.should_not_receive(:follow) }

      specify "until time has come" do
        worker.run
      end
    end

    context "should process pending job" do
      before { Tumblr.should_receive(:follow).and_return(true) }

      specify "when time is right" do
        Timecop.freeze(Time.now + 6.minutes) do
          worker.run
        end
      end
    end
  end
end
