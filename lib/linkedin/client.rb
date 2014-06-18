module LinkedIn
  class Client
    extend Forwardable

    include Configuration
    include LinkedIn::API::Authentication
    include LinkedIn::API::Profiles
    include LinkedIn::API::NetworkUpdates
    include LinkedIn::API::Companies

    HTTP_METHODS = [:get, :post, :put, :patch, :delete, :headers].freeze

    attr_writer :profile_fields
    attr_reader :access_token

    def_delegators :@access_token, :expires?, :expired?, :request

    def initialize(options={}, &block)
      configure options, &block
      self.access_token ||= self.config.access_token.to_s
    end

    def auth_code
      connection.auth_code
    end

    def connection
      @connection ||= OAuth2::Client.new config.key, config.secret, oauth2_options do |faraday|
        faraday.request :url_encoded
        faraday.request :json
        faraday.request :linkedin_format, config.request_format

        faraday.response :mashify
        faraday.response :linkedin_errors
        faraday.response :logger, config.logger
        faraday.response :json, content_type: /\bjson$/

        faraday.adapter :net_http
      end
    end

    def access_token=(token)
      if token.kind_of? String
        options = { access_token: token, mode: :query, param_name: 'oauth2_access_token' }
        return @access_token = OAuth2::AccessToken.from_hash(connection, options)
      end

      @access_token = token
    end

    def profile_fields
      return @profile_fields if @profile_fields
      scopes = config.scope unless config.scope.respond_to?(:values)
      scopes ||= config.scope

      @profile_fields = scopes.reduce([]) { |fields, scope| fields + LinkedIn.send(scope) }
    end

    def method_missing(method, *args, &body)
      return simple_request(method, args[0], (args[1] || {}), &body) if HTTP_METHODS.include? method
      super
    end

    def self.default_config
      {
        request_format: :json,

        key: nil,
        secret: nil,
        access_token: nil,

        scope: ['r_basicprofile'],
        state: Utils.generate_random_state,
        redirect_uri: 'http://localhost',

        logger: Logger.new('/dev/null')
      }
    end

    private

    def simple_request(method, path, options={}, &body)
      request(method, path, options, &body).body
    end

    def auth_code
      connection.auth_code unless connection.nil?
    end

    def oauth2_options
      { site:          'https://api.linkedin.com',
        authorize_url: 'https://www.linkedin.com/uas/oauth2/authorization',
        token_url:     'https://www.linkedin.com/uas/oauth2/accessToken' }
    end
  end
end
