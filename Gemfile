source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.2.2'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Utils
gem 'http'
gem 'oj'

# Controller
gem 'inherited_resources'

# Model
gem 'active_record_upsert'
gem 'jsonb_accessor'
gem 'kaminari'
gem 'mobility'

# View
gem 'active_link_to'
gem 'cocoon'
gem 'simple_form'

# Assets
gem 'bootstrap'
gem 'jquery-rails'

source 'https://rails-assets.org' do

end

# Jobs
gem 'sidekiq'
  gem 'sidekiq-cron'
  gem 'sidekiq-failures'
  gem 'sinatra', require: false

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

group :development do
  ## Performance
  gem 'spring'
  gem 'spring-watcher-listen'

  ## Tools
  gem 'letter_opener'

  ## Guard
  gem 'guard'
  gem 'guard-bundler'
  gem 'guard-migrate'
  gem 'guard-rspec', require: false

  ## Debugging
  gem 'pry-rails'
end
