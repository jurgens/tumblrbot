namespace :tumblr do
  desc "process jobs"
  task :run => :environment do
    result = Worker.new.run
    puts 'OK' unless result.nil?
  end
end