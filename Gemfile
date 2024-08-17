source "https://rubygems.org"

gem 'rails', '~> 6.1.0'
gem 'mongoid', '~> 8.0'
gem 'devise', '~> 4.8'
gem 'rotp', '~> 2.0'
gem 'bigdecimal'
gem "mutex_m"
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
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
