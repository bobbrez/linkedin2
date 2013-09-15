module LinkedIn
  module FaradayMiddleware
    require 'linkedin/faraday_middleware/linkedin_format_request'

    Faraday.register_middleware :request, linkedin_format: lambda { LinkedinFormatRequest }
  end
end
