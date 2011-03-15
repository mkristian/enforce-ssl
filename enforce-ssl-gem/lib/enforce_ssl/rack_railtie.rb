require 'enforce_ssl/base_railtie'
require 'enforce_ssl/enforce_ssl_rack'

module EnforceSsl
  class FilterRailtie < Rails::Railtie

    config.before_configuration do |app|
      BaseRailtie.configuration(app)
      app.config.middleware.insert_before(::ActionDispatch::Static, EnforceSslRack)
    end
  end
end
