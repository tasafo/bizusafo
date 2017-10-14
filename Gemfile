source 'https://rubygems.org'

ruby '2.4.2'

gem 'rails', '4.2.10'
gem 'rails-i18n'
gem 'mysql2'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 1.2'

gem 'devise'
gem 'kaminari'
gem 'omniauth-facebook'
gem 'acts-as-taggable-on'
gem 'kaminari-bootstrap', '~> 3.0.1'

gem 'rake', '10.5.0'

group :development do
  gem 'dotenv-rails', :require => 'dotenv/rails-now'
  gem 'quiet_assets'
end

group :development, :test do
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :test do
  gem 'capybara'
  gem 'simplecov'
  gem 'shoulda-matchers'
  gem 'capybara-webkit'
  gem 'selenium-webdriver'
  gem 'codeclimate-test-reporter', require: nil
end

group :production do
  gem 'pg', '>= 0.18.1'  # previous version, 0.17.1, wasn't installing in ruby 2.2
  gem 'rails_12factor'
end

