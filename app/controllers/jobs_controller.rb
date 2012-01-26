class JobsController < ApplicationController
  def clear
    Job.clear

    respond_to do |format|
      format.js
    end
  end
end
