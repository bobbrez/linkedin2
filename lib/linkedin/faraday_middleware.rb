module LinkedIn
  module FaradayMiddleware
    require 'linkedin/faraday_middleware/linkedin_format_request'
    require 'linkedin/faraday_middleware/linkedin_error_response'

    if Faraday::Middleware.respond_to? :register_middleware
      Faraday::Request.register_middleware linkedin_format: lambda { LinkedinFormatRequest }
      Faraday::Response.register_middleware linkedin_errors: lambda { LinkedinErrorResponse }
    end
  end
end
