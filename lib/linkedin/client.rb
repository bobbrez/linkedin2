module LinkedIn
  class Client
    extend Forwardable

    include Configuration
    include API

    HTTP_METHODS = [:get, :post, :put, :patch, :delete, :headers].freeze

    attr_reader :access_token

    def_delegators :@access_token, :expires?, :expired?, :request

    def initialize(options={}, &block)
      configure options, &block
      self.access_token ||= self.config[:access_token].to_s
    end

    def connection 
      @connection ||= OAuth2::Client.new(config.key, config.secret, oauth2_options) do |faraday|
        faraday.request :url_encoded
        faraday.request :json
        faraday.request :linkedin_format, defaults(:request_format)

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

    def access_token_request(method, path, opts={}, &block)
      response = access_token.send method, path, opts, &block
      response.body
    end

    def method_missing(method, *args, &body)
      return simple_request(method, args[0], (args[1] || {}), &body) if HTTP_METHODS.include? method
      super
    end

    def self.default_config
      {
        authorize_path: '/uas/oauth2/authorization',
        access_token_path: '/uas/oauth2/accessToken',
        api_host: 'https://api.linkedin.com',
        auth_host: 'https://www.linkedin.com',
        request_format: :json,

        key: nil,
        secret: nil,
        access_token: nil,

        scope: 'r_basicprofile',
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
      { site: config.api_host,
        authorize_url: url_for(:authorize),
        token_url: url_for(:access_token) }
    end

    def url_for(option_key)
      host = config.auth_host
      path = config["#{option_key}_path".to_sym]
      "#{host}#{path}"
    end
  end
end
