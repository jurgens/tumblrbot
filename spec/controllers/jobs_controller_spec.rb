require 'spec_helper'

describe JobsController do
  describe "clear" do
    before do
      Job.should_receive(:clear)
      post :clear, format: :js
    end

    it { should respond_with_content_type :js }
  end
end
