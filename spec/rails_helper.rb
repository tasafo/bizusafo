# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'simplecov'
SimpleCov.start 'rails'

if ENV['CI']
  require 'simplecov-cobertura'
  SimpleCov.formatter = SimpleCov::Formatter::CoberturaFormatter
end

ENV['RAILS_ENV'] ||= 'test'

require 'spec_helper'
require File.expand_path('../config/environment', __dir__)
require 'rspec/rails'
require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/cuprite'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.global_fixtures = :all

  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = :random

  ##
  # Facilita encontrar traducoes esquecidas.
  ##
  config.before(:all, type: :model) do
    @_i18n_exception_handler = I18n.exception_handler
    I18n.exception_handler = lambda { |*args| raise args.first.to_s }
  end

  config.after(:all, type: :model) do
    I18n.exception_handler = @_i18n_exception_handler
  end

  config.include Capybara::DSL

  Capybara.register_driver :cuprite do |app|
    Capybara::Cuprite::Driver.new(
      app,
      url_blacklist: %w[addthis.com facebook.net facebook.com gravatar.com],
      headless: true
    )
  end

  Capybara.javascript_driver = :cuprite
  Capybara.server = :puma, { Silent: true }

  config.include(Shoulda::Matchers::ActiveModel, type: :model)
  config.include(Shoulda::Matchers::ActiveRecord, type: :model)
end
