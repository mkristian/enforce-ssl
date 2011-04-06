require 'rails'

module EnforceSsl
  module EnforceSslFilter
    def enforce_ssl
      controller = self
      is_ssl = controller.request.port.to_i == Rails.configuration.ssl_port.to_i
      is_not_ssl = controller.request.port.to_i == Rails.configuration.no_ssl_port.to_i
      
      controller.request.env['HTTPS'] = is_ssl ? "on" : nil
      
      if is_ssl
        # use only if max_age is set and only in production mode since it
        # needs a proper (not self-signed) certificate
        if Rails.configuration.hsts_max_age && Rails.env == "production"
          subdomain = Rails.configuration.hsts_include_sub_domain == true ? " ; includeSubDomains" : ""
         controller. response.headers['Strict-Transport-Security'] = "max-age=#{Rails.configuration.hsts_max_age.to_i}" + subdomain
          
        end
      elsif is_not_ssl
        controller.redirect_to "https://" + controller.request.host + ":#{Rails.configuration.ssl_port}" + controller.request.fullpath
        controller.flash.keep
        return false
      end
    end
  end
end
