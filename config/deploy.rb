$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

require 'rvm/capistrano'
require 'capistrano/ext/multistage'
require 'bundler/capistrano'

set :stages,              %w(staging production)
set :default_stage,       "staging"

set :application, "tumblrbot"
set :repository,  "git://github.com/jurgens/tumblrbot.git"

set :use_sudo,            false
set :scm,                 :git
set :branch,              "master"
set :deploy_via,          :remote_cache

set :rvm_ruby_string, '1.9.3'
set :rvm_type, :user

# Create uploads directory and link, remove rep clone
task :build_symlinks, :roles => :app do
 run "cp #{shared_path}/config/oauth.yml #{release_path}/config/oauth.yml"
end

namespace :deploy do
  task :restart do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{deploy_to}/current && bundle exec unicorn_rails -c #{unicorn_conf} -E #{rails_env} -D; fi"
  end
  task :start do
    run "bundle exec unicorn_rails -c #{unicorn_conf} -E #{rails_env} -D"
  end
  task :stop do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end
end

task :pipeline_precompile do
  run "cd #{release_path}; RAILS_ENV=#{rails_env} bundle exec rake assets:precompile"
end

after "deploy:update_code", "build_symlinks", "deploy:migrate", "deploy:cleanup", "pipeline_precompile"
