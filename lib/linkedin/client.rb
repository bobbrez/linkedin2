require 'byebug'

module LinkedIn
  class Client
    include Configuration
    include API::Authentication

    def initialize(options={})
      configure options
    end

    def connection 
      OAuth2::Client.new key, secret, oauth2_options
    end

    private

    def auth_code
      connection.auth_code unless connection.nil?
    end

    def oauth2_options
      { site: options[:api_host],
        authorize_url: url_for(:authorize),
        token_url: url_for(:access_token) }
    end

    def url_for(option_key)
      host = options[:auth_host]
      path = options["#{option_key}_path".to_sym]
      "#{host}#{path}"
    end
  end
end
