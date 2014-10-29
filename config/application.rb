require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# ENV.update YAML.load_file('config/settings.yml')[Rails.env] rescue {}
ENV.update YAML.load(File.read('config/settings.yml'))[Rails.env] rescue {}

module Giver
  class Application < Rails::Application
    config.assets.paths << Rails.root.join('vendor')
    config.autoload_paths += %W["#{config.root}/app/validators/"]
  end
end
