source "https://rubygems.org"

ruby "3.2.2"

gem "rails", "~> 7.1.3"

gem "sprockets-rails"

gem "sqlite3", "~> 1.4"

gem "puma", ">= 5.0"

gem "jsbundling-rails"

gem "turbo-rails"

gem "stimulus-rails"

gem "cssbundling-rails"

gem "jbuilder"

gem "sentry-ruby"
gem "sentry-rails"

gem 'slim-rails', '~> 3.6', '>= 3.6.3'

gem 'omniauth'
gem 'omniauth-github'
gem 'omniauth-rails_csrf_protection'

gem "tzinfo-data", platforms: %i[ windows jruby ]

gem "bootsnap", require: false

gem 'rails-i18n'

gem 'active_storage_validations'
# gem 'aws-sdk-s3'
gem 'file_validators'
gem 'image_processing'

gem 'simple_form', '~> 5.3'

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
  gem 'faker'
  gem 'dotenv'
  gem 'byebug'
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

group :production do
  gem "pg"
end
