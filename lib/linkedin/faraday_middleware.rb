module LinkedIn
  module FaradayMiddleware
    Dir[ File.expand_path('../faraday_middleware/**/*.rb', __FILE__) ].each { |f| require f }

    if Faraday::Middleware.respond_to? :register_middleware
      Faraday::Request.register_middleware linkedin_credentials: lambda { CredentialsRequest }
      Faraday::Request.register_middleware linkedin_format: lambda { FormatRequest }
      Faraday::Request.register_middleware linkedin_user_agent: lambda { UserAgentRequest }

      Faraday::Response.register_middleware linkedin_errors: lambda { ErrorResponse }
    end
  end
end
