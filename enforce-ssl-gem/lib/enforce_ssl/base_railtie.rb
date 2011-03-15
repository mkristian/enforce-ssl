require 'rails'

module EnforceSsl
  class BaseRailtie

    def self.configuration(app)
      app.config.class.class_eval do
        attr_accessor :no_ssl_port
        attr_accessor :ssl_port
        attr_accessor :hsts_max_age
        attr_accessor :hsts_include_sub_domain
      end
      if Rails.env == "production"
        app.config.no_ssl_port = 80
        app.config.ssl_port = 443
      else
        app.config.no_ssl_port = 8080
        app.config.ssl_port = 8443
      end
      app.config.hsts_include_sub_domain = false
      app.config.hsts_max_age = 31536000 # one year in seconds
    end
  end
end
