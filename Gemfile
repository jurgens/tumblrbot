source 'http://rubygems.org'

gem 'rails', '3.2'
gem 'rack', git: 'https://github.com/rack/rack.git'
gem 'jquery-rails'
gem 'bson_ext'
gem 'mongoid'
gem 'twitter-bootstrap-rails'
gem 'rack', git: 'https://github.com/rack/rack.git'
gem 'omniauth'
gem 'omniauth-tumblr'
gem 'haml'
gem 'sass'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails'
  gem 'uglifier'
end

group :test do
  # Pretty printed test output
  gem 'turn', '~> 0.8.3', :require => false
  gem 'database_cleaner'
  gem 'mongoid-rspec'
  gem 'factory_girl_rails'
  gem 'timecop'
  gem 'shoulda'
end

group :development, :test do
  gem 'rspec-rails'
end

group :development do
  gem 'guard'
  gem 'guard-rspec'
  gem 'capistrano'
end
