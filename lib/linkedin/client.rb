module LinkedIn
  class Client
    include Configuration
    include LinkedIn::API

    def initialize(**config, &block)
      configure config, &block
    end

    def credentials
      @credentials ||= Credentials.new configuration
    end

    def connection
      @connection ||= Faraday.new 'https://api.linkedin.com' do |conn|
        conn.request :json
        conn.request :url_encoded
        conn.request :linkedin_credentials, configuration
        conn.request :linkedin_format
        conn.request :linkedin_user_agent

        conn.response :linkedin_errors
        conn.response :mashify
        conn.response :logger, configuration.logger
        conn.response :json, content_type: /\bjson$/

        conn.adapter Faraday.default_adapter
      end
    end

    def headers
      @headers ||= {}
    end

    def params
      @params ||= {}
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
  end
end
