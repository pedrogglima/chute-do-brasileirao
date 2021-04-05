# frozen_string_literal: true

source('https://rubygems.org')
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby('2.6.3')

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem('rails', '~> 6.1.0')
# Use postgresql as the database for Active Record
gem('pg', '~> 1.1')
# Use Puma as the app server
gem('puma', '~> 5.0')
# Use SCSS for stylesheets
gem('sass-rails', '>= 6')
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem('webpacker', '~> 5.0')
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem('turbolinks', '~> 5')
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem('jbuilder', '~> 2.7')
# Use Redis adapter to run Action Cable in production
gem('redis', '~> 4.0')
# Add namespace to redis
gem('redis-namespace', '~> 1.5', '>= 1.5.2')
# Lib for Redis connection
gem('hiredis', '~> 0.6.0')
# Use Sidekiq as background scheduler
gem('sidekiq', '~> 6.0.7')
# Dependency for Sidekiq
gem('connection_pool', '~> 2.2.0')
# Mimicking cron utility.
gem('sidekiq-scheduler', '~> 3.0.1')
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Use Active Storage variant
gem('image_processing', '~> 1.2')

# We need to pull from master because of omniauth 2 compatibility
gem 'devise', github: 'heartcombo/devise', branch: 'master'
# Auth with Twitter, etc
gem 'omniauth', '~> 2.0', '>= 2.0.3'
gem 'omniauth-google-oauth2', '~> 0.8.1'
gem 'omniauth-twitter', '~> 1.4'

# Needed for Oauth2
gem 'omniauth-rails_csrf_protection', '~> 1.0.0'
# Pagination
gem 'pagy', '~> 3.11'
# S3 Buckets
gem 'aws-sdk-s3', '~> 1.88', '>= 1.88.1'

gem('haml')

# Auth with JWT
gem('jwt', '~> 2.2', '>= 2.2.2')
# Authorization system
gem('pundit', '~> 2.1.0')

# Reduces boot times through caching; required in config/boot.rb
gem('bootsnap', '>= 1.4.4', require: false)

gem(
  'scrap_cbf',
  github: 'pedrogglima/scrap-cbf',
  branch: 'master',
  ref: '5f20dd6'
)
gem(
  'scrap_cbf_record',
  github: 'pedrogglima/scrap-cbf-record',
  branch: 'master',
  ref: '4e20b8c'
)

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'faker', '~> 2.14.0'
  gem 'pry', '~> 0.12.2'
  gem 'rspec-rails', '~> 4.0.1'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  gem 'listen', '~> 3.3'
  gem 'rack-mini-profiler', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'haml-rails', '~> 2.0'
  gem 'rubocop', require: false
  gem 'spring'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  # gem 'capybara', '~> 3.33.0'
  # gem 'selenium-webdriver', '~> 3.142.7'
  # Clean database test after each interaction
  gem 'database_cleaner', '~> 1.8.5'
  gem 'factory_bot_rails', '~>  5.2.0'
  gem 'mock_redis', '~> 0.16.1'
  gem 'pundit-matchers', '~> 1.6.0'
  gem 'rspec-expectations', '~> 3.4'
  gem 'rspec-json_expectations', '~> 1.2'
  gem 'rspec-sidekiq', '~> 3.1.0'
  gem 'shoulda-matchers', '~> 4.4.1'
  gem 'timecop', '~> 0.9.2'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem('tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby])
