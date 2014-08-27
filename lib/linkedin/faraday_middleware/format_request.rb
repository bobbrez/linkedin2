module LinkedIn
  module FaradayMiddleware
    class FormatRequest < Faraday::Middleware
      HEADER_NAME  = 'X-Li-Format'.freeze

      def initialize(app = nil, format = :json)
        super app
        @format = format
      end

      def call(env)
        env[:request_headers].reverse_merge! HEADER_NAME => @format.to_s unless @format.blank?
        @app.call env
      end
    end
  end
end
