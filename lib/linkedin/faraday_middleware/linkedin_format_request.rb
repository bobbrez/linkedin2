module LinkedIn
  module FaradayMiddleware
    class LinkedinFormatRequest < Faraday::Middleware
      def initialize(app = nil, format = :json)
        super app

        @format = format
      end

      def call(env)
        set_request_format! env[:url] unless has_format?(env[:url])

        @app.call env
      end

      def has_format?(url)
        !(url.query =~ /(^|&)format=/).nil?
      end

      def set_request_format!(url)
        ar = URI.decode_www_form(url.query || '') << ['format', @format]
        url.query = URI.encode_www_form(ar)
      end
    end
  end
end
