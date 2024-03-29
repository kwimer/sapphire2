source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.5'

# Core
gem 'rails', '5.2.3'
gem 'bootsnap', require: false
gem 'oj'
gem 'pg'
gem 'puma'
gem 'rack-timeout'

# Utils
gem 'http'
gem 'rollbar'

# Model
gem 'acts_as_list'
gem 'counter_culture'
gem 'devise'
gem 'filterrific'
gem 'friendly_id'
gem 'jsonb_accessor'
gem 'kaminari'
  gem 'bootstrap4-kaminari-views'
gem 'mobility'
gem 'normalizr'
gem 'pg_search'
gem 'request_store'
gem 'virtus'
gem 'where_exists'

# Controller
gem 'inherited_resources'

# View
gem 'active_link_to'
gem 'cocoon'
gem 'meta-tags'
gem 'simple_form'

# Templates
gem 'coffee-rails'
gem 'jbuilder'
gem 'sassc-rails'
gem 'uglifier'

# Assets
gem 'sprockets-rails'
gem 'bootstrap'
gem 'jquery-rails'
gem 'font-awesome-rails'
gem 'bootstrap-slider-rails'

source 'https://rails-assets.org' do
  gem 'rails-assets-autosize'
  gem 'rails-assets-bootstrap-rating'
  gem 'rails-assets-selectize'
  gem 'rails-assets-slick.js'
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
    gem 'guard-pumadev'
    gem 'guard-rspec', require: false
    gem 'guard-sidekiq'

  # Debugging
  gem 'pry-rails'
end

group :development, :test do
  gem 'dotenv-rails'
end
