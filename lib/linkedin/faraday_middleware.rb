module LinkedIn
  module FaradayMiddleware
    require 'linkedin/faraday_middleware/linkedin_format_request'
    require 'linkedin/faraday_middleware/linkedin_error_response'

    Faraday.register_middleware :request, linkedin_format: lambda { LinkedinFormatRequest }

    Faraday.register_middleware :response, linkedin_errors: lambda { LinkedinErrorResponse }
  end
end
