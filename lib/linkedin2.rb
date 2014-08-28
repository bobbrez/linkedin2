require 'active_support'
require 'active_support/core_ext'
require 'active_support/time'
require 'faraday_middleware'
require 'hashie'
require 'oauth2'

require 'linkedin/version'
require 'linkedin/errors'
require 'linkedin/fields'

require 'linkedin/utils'
require 'linkedin/configuration'
require 'linkedin/base'
require 'linkedin/profile'
require 'linkedin/company'
require 'linkedin/industries'
require 'linkedin/api'
require 'linkedin/credentials'
require 'linkedin/response'
require 'linkedin/faraday_middleware'
require 'linkedin/client'

module LinkedIn
  def self.new(config = {}, &block)
    Client.new config, &block
  end

  [:r_basicprofile, :r_emailaddress, :r_fullprofile, :r_contactinfo, :r_network, :rw_groups, :rw_nus, :w_messages].each do |field|
    define_singleton_method field do
        Fields.const_get field.to_s.upcase
    end
  end
end
