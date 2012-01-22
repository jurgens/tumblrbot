namespace :tumblr do
  desc "process jobs"
  task :run => :environment do

    result = Worker.new.run
    puts result.nil? ? 'Skip' : 'Done'
  end
end