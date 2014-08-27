module LinkedIn
  module FaradayMiddleware
    class AuthRequest < Faraday::Middleware
      PARAM_NAME  = 'oauth2_access_token'.freeze

      extend Forwardable
      def_delegators :'Faraday::Utils', :parse_query, :build_query

      def initialize(app, auth)
        super app
        @auth = auth
      end

      def call(env)
        params = query_params(env[:url]).reverse_merge PARAM_NAME => @auth.access_token
        token = params[PARAM_NAME]

        env[:url].query = build_query params unless token.blank?

        @app.call env
      end

      private

      def query_params(url)
        return {} if url.query.blank?
        parse_query url.query
      end
    end
  end
end
