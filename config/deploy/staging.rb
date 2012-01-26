set :domain,              "50.56.207.253"
set :deploy_to,           "/home/machinist/tumblrbot"
set :rails_env,           "staging"
set :user,                "machinist"
set :runner,              "machinist"

set :unicorn_conf, "#{deploy_to}/current/config/unicorn.rb"
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"

role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db,  domain, :primary => true # This is where Rails migrations will run
