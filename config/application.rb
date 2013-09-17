require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  Bundler.require(*Rails.groups(:assets => %w(development test)))
end

module GameTranslator
  class Application < Rails::Application
    config.time_zone = 'Brasilia'

    config.i18n.load_path += Dir[Rails.root.join('config/locales/**/*.yml').to_s]

    config.i18n.default_locale = 'pt-BR'

    config.i18n.available_locales = YAML.load(File.open("#{ Rails.root }/config/language_codes.yml"))

    config.encoding = "utf-8"

    config.filter_parameters += [:password]

    config.active_support.escape_html_entities_in_json = true

    config.active_record.whitelist_attributes = false

    config.assets.enabled = true

    config.assets.version = '1.0'

    WillPaginate.per_page = 10
  end
end