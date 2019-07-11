source "https://rubygems.org"

ruby "2.6.0"

gem "activerecord-session_store"
gem "bootsnap", require: false
gem "config"
gem "draper"
gem "jquery-rails", "~>4.3", ">= 4.3.3"
gem "mysql2"
gem "nokogiri", ">= 1.8.5"
gem "puma"
gem "sassc-rails"
gem "rails"

group :assets do
  gem "coffee-rails"
  gem "uglifier", ">= 1.3.0"
end

group :development do
  gem "better_errors"
  gem "binding_of_caller"
  gem "brakeman"
  gem "bundler-audit", require: false
  gem "hirb"
  gem "listen"
  gem "overcommit"
  gem "ruby_dep"
end

group :test do
  gem "capybara"
  gem "capybara-screenshot"
  gem "capybara-selenium"
  gem "chromedriver-helper"
  gem "faker"
  gem "fuubar"
  gem "launchy"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "webmock"
end

group :development, :test, :assets do
  gem "dotenv-rails"
end

group :development, :test do
  gem "factory_bot_rails"
  gem "pry-byebug"
  gem "ramsey_cop"
  gem "rspec-its"
  gem "rspec-rails"
  gem "timecop"
end

