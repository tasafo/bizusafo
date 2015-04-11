require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Bizusafo
  class Application < Rails::Application
    
    config.encoding = "utf-8"

    config.time_zone = 'Brasilia'
    
    config.i18n.enforce_available_locales = false
    config.i18n.available_locales = ["en", "pt-BR"]
    config.i18n.default_locale = :"pt-BR"
  end
end
