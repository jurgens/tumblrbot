class HomeController < ApplicationController
  def index
    @authentication = Authentication.first
    @counters = Job.counters
    @settings = Settings.instance
  end

  def upload
    @importer = Importer.new
    @report = @importer.run(params[:file].path)

    redirect_to({:action => 'index'}, notice: "Added #{@report[:successes]} new jobs, #{@report[:failures]} failed to add")
  end
end
