module LinkedIn
  class Client
    include Configuration
    include LinkedIn::API

    attr_reader :headers, :params

    def initialize(**config, &block)
      configure config, &block
      self.auth.access_token = self.configuration.access_token.to_s
      @headers = { 'User-Agent' => "LinkedIn2 Gem v#{ LinkedIn::VERSION }" }
    end

    def auth
      @auth ||= Auth.new
    end

    def connection
      @connection ||= Faraday.new 'https://api.linkedin.com' do |conn|
        conn.request :json
        conn.request :url_encoded
        conn.request :linkedin_auth, auth
        conn.request :linkedin_format

        conn.response :linkedin_errors
        conn.response :mashify
        conn.response :logger, configuration[:logger]
        conn.response :json, content_type: /\bjson$/

        conn.adapter Faraday.default_adapter
      end
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

    def override(global, overrides)
      global.to_h.merge overrides.to_h
    end

    def execute(root, method: :get, selector: nil, fields: fields, **opts)
      rendered_fields = Fields.render fields
      query = ['v1', root, selector.to_param, opts[:path]].compact.join('/').concat(rendered_fields)

      response = connection.send method, query do |req|
        req.headers.update override(@headers, opts[:headers])
        req.params.update override(@params, opts[:params])
        req.body = opts[:body].to_json if opts[:body]
      end

      Response.new response
    end

    def oauth2_options
      { site:          'https://api.linkedin.com',
        authorize_url: 'https://www.linkedin.com/uas/oauth2/authorization',
        token_url:     'https://www.linkedin.com/uas/oauth2/accessToken' }
    end
  end
end
