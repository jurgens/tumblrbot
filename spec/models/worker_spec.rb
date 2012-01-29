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
    before { @successful_job = Factory :successful_job }
    before { @pending = Factory :job }
    before { Settings.status = 'on' }

    context "should not process pending job" do
      before { Tumblr.should_not_receive(:follow) }

      specify "right after previous job" do
        worker.run
      end
    end

    context "should process a job" do
      before do
        Tumblr.should_receive(:follow).and_return(true)
      end
      specify do
        Timecop.freeze(Time.now + 7.minutes) do
          worker.run
        end
      end
    end
  end

  describe "#is_good_time", :focus => true do
    specify "when no jobs were run yet" do
      worker.is_good_time.should be_true
    end

    context "job was processed earlier" do
      before { Factory :successful_job }
      specify "when time is right" do
        Timecop.freeze(Time.now + 7.minutes) do
          worker.is_good_time.should == true
        end
      end
    end
  end

  describe "#has_jobs" do
    context "no jobs" do
      specify { worker.has_jobs.should be_false }
    end

    context "there are jobs" do
      before { Factory :job }
      specify { worker.has_jobs.should be_true }
    end
  end
end
