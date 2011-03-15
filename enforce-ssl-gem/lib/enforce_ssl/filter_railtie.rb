require 'enforce_ssl/base_railtie'
require 'enforce_ssl/enforce_ssl_filter'

module EnforceSsl
  class FilterRailtie < Rails::Railtie

    config.before_configuration do |app|
      BaseRailtie.configuration(app)
      ::ActionController::Base.send :include, EnforceSslFilter
      ::ActionController::Base.prepend_before_filter(:enforce_ssl)
    end
  end
end
