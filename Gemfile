source 'https://rubygems.org'

ruby '2.2.1'

gem 'rails', '4.1.1'
gem 'rails-i18n'
gem 'mysql2'
gem 'sass-rails', '~> 4.0.3'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 1.2'

gem 'devise'
gem 'kaminari'
gem 'omniauth-facebook'
gem 'acts-as-taggable-on'
gem 'kaminari-bootstrap', '~> 3.0.1'

group :development, :test do
  gem 'rspec-rails', '~> 2.14.2'
  gem 'pry'
end

group :test do
  gem 'simplecov'
  gem 'shoulda-matchers'
end

group :production do
  gem 'pg', '0.18.1'  # previous version, 0.17.1, wasn't installing in ruby 2.2
  gem 'rails_12factor'
end

group :doc do
  gem 'sdoc', require: false
end
