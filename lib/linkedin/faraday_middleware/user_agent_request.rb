module LinkedIn
  module FaradayMiddleware
    class UserAgentRequest < Faraday::Middleware
      def call(env)
        env[:request_headers].reverse_merge! 'User-Agent' => "LinkedIn2 Gem v#{ LinkedIn::VERSION }"
        @app.call env
      end
    end
  end
end
