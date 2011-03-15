module EnforceSsl
  class EnforceSslRack

    def initialize(app)
      @app = app
    end
    
    def call(env)
      scheme = env["rack.url_scheme"]
      port = env["SERVER_PORT"]
      is_ssl = port.to_i == Rails.configuration.ssl_port.to_i
      is_not_ssl = port.to_i == Rails.configuration.no_ssl_port.to_i

      if is_ssl
        @status, @headers, @body = @app.call(env)
        
        # use only if max_age is set and only in production mode since it
        # needs a proper (not self-signed) certificate
        if Rails.configuration.hsts_max_age && Rails.env == "production"
          subdomain = Rails.configuration.hsts_include_sub_domains? ? " ; includeSubDomains" : ""
          @headers['Strict-Transport-Security'] = "max-age=#{Rails.configuration.hsts_max_age.to_i}" + subdomain
          
        end
      elsif is_not_ssl
        @headers = { "location" => "https://" + env["HTTP_HOST"].sub(/\:.*/, '') + ":#{Rails.configuration.ssl_port}" + env["PATH_INFO"] }
        @status = 302
        @body = ''
      else
        @status, @headers, @body = @app.call(env)
      end
      [@status, @headers, @body]
    end
  end
end
