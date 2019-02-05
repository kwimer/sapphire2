source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

# Core
gem 'rails', '5.2.2'
gem 'bootsnap', require: false
gem 'pg'
gem 'puma'
gem 'rack-timeout'

# Utils
gem 'http'
gem 'oj'

# Model
gem 'active_record_upsert'
gem 'friendly_id'
gem 'jsonb_accessor'
gem 'kaminari'
gem 'mobility'

# Controller
gem 'inherited_resources'

# View
gem 'active_link_to'
gem 'cocoon'
gem 'simple_form'

# Assets
gem 'coffee-rails'
gem 'jbuilder'
gem 'sassc-rails'
gem 'uglifier'

gem 'sprockets-rails'
gem 'bootstrap'
gem 'jquery-rails'

source 'https://rails-assets.org' do

end

# Jobs
gem 'sidekiq'
  gem 'sidekiq-cron'
  gem 'sidekiq-failures'
  gem 'sidekiq-limit_fetch'
    gem 'sinatra', require: false

group :development do
  # Performance
  gem 'spring'
  gem 'spring-watcher-listen'

  # Tools
  gem 'letter_opener'

  # Guard
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-migrate'
  gem 'guard-rspec', require: false

  # Debugging
  gem 'pry-rails'
end

group :development, :test do
  gem 'dotenv-rails'
end
