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

require 'linkedin/api/authentication'
require 'linkedin/api/profiles'
require 'linkedin/api/network_updates'
require 'linkedin/api/companies'
require 'linkedin/api/groups'
require 'linkedin/api/industries'
require 'linkedin/api/jobs'
require 'linkedin/api/permissions'

require 'linkedin/client'

module LinkedIn
  def self.new(options = {}, &block)
    Client.new options, &block
  end

  [:r_basicprofile, :r_emailaddress, :r_fullprofile, :r_contactinfo, :r_network, :rw_groups, :rw_nus, :w_messages].each do |field|
    define_singleton_method field do
        API::Permissions.const_get field.to_s.upcase
    end
  end
end
