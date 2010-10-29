# Copyright (c) 2005 David Heinemeier Hansson
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
require 'rails'

class EnforceSslRailtie < Rails::Railtie

  config.before_configuration do |app|
    app.config.class.class_eval do
      attr_accessor :ssl_port
    end
    app.config.ssl_port = 443
  end
end

module EnforceSsl
  def self.included(controller)
    #controller.extend(ClassMethods)
    controller.before_filter(:enforce_ssl)
  end

  # module ClassMethods
  #   # Specifies that the named actions requires an SSL connection to be performed (which is enforced by ensure_proper_protocol).
  #   def ssl_required(*actions)
  #     write_inheritable_array(:ssl_required_actions, actions)
  #   end

  #   def ssl_allowed(*actions)
  #     write_inheritable_array(:ssl_allowed_actions, actions)
  #   end
  # end
  
  # protected
  #   # Returns true if the current action is supposed to run as SSL
  #   def ssl_required?
  #     (self.class.read_inheritable_attribute(:ssl_required_actions) || []).include?(action_name.to_sym)
  #   end
    
  #   def ssl_allowed?
  #     (self.class.read_inheritable_attribute(:ssl_allowed_actions) || []).include?(action_name.to_sym)
  #   end

  private
    def enforce_ssl
      #return true if ssl_allowed?

      is_ssl = request.port.to_i == Rails.configuration.ssl_port.to_i
      request.env['HTTPS'] = is_ssl ? "on" : nil

      #if ssl_required? && !request.ssl?
      unless is_ssl
        redirect_to "https://" + request.host + ":#{Rails.configuration.ssl_port}" + request.fullpath
        flash.keep
        return false
      #elsif request.ssl? && !ssl_required?
      #  redirect_to "http://" + request.host + request.request_uri
      #  flash.keep
      #  return false
      end
    end
end
ActionController::Base.send(:include, EnforceSsl)
