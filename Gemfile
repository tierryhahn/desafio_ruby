source "https://rubygems.org"

gem 'rails', '~> 7.1.3'
gem 'mongoid', '~> 8.0'
gem 'devise', '~> 4.8'
gem 'rotp', '~> 2.0'
gem 'bigdecimal'
gem "mutex_m"
gem 'httparty'
gem 'dotenv-rails', groups: [:development, :test]
gem 'sidekiq'
gem 'sidekiq-scheduler', '~> 5.0'
gem 'redis'
gem "sprockets-rails"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  gem "brakeman", require: false

  gem "rubocop-rails-omakase", require: false
  
  gem 'rspec-rails'
  gem 'webmock'
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem 'factory_bot_rails'
  gem 'faker'
end
