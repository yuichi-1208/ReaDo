require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ReaDo
  class Application < Rails::Application
    config.time_zone = 'Tokyo'
    # config.active_record.default_timezone = :local
    config.load_defaults 5.2
    config.i18n.default_locale = :ja

    config.generators do |g|
      g.assets false
      g.helper false
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: false,
        request_specs: false
      g.fixture_replacement :factory_bot, dir: "spec/factories"
    end
  end
end
