require 'forwardable'
require 'oauth2'
require 'active_support'
require 'active_support/core_ext'
require 'active_support/time'
require 'faraday'
require 'faraday_middleware'
require 'yaml'
require 'hashie'

require 'linkedin/version'
require 'linkedin/error'
require 'linkedin/utils'
require 'linkedin/configuration'
require 'linkedin/base'
require 'linkedin/profile'
require 'linkedin/company'
require 'linkedin/industry'
require 'linkedin/faraday_middleware'
require 'linkedin/api'
require 'linkedin/client'

module LinkedIn
  def new(options={}, &block)
    Client.new options, &block
  end

  def self.method_missing(method, *args, &block)
    Client.send(method, *args, &block) if Client.respond_to?(method)
  end
end
