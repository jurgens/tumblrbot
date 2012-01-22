class HomeController < ApplicationController
  def index
    @authentication = Authentication.first
    @counters = Job.counters
  end
end
