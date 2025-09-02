source "https://rubygems.org"

ruby "3.4.5"

gem "rails", "~> 7.1.3", ">= 7.1.3.2"
gem "sprockets-rails"
gem "sqlite3", "~> 1.4"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"

#custom
gem 'devise', '~> 4.9', '>= 4.9.4'
gem 'friendly_id', '~> 5.5', '>= 5.5.1'
gem 'ransack', '~> 4.3'
gem 'slim-rails'  
gem 'sassc-rails'


gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false
group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
end

group :development do
  gem "web-console"
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rspec', require: false  # if you use RSpec
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
