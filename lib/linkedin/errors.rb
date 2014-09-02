module LinkedIn
  class Error < StandardError; end

  class ServiceError < Error
    attr_reader :source

    def initialize(response = {})
      @source = Hashie::Mash.new response
    end

    def message
      return self.class.name if body.message.empty?
      body.message
    end

    def status
      response.status
    end

    def body
      response.body
    end

    def request
      @request ||= Hashie::Mash.new url: source.url, headers: source.request_headers, params: source.params
    end

    def response
      @response ||= Hashie::Mash.new status: source.status, body: source.body, headers: source.response_headers
    end
  end

  class BadRequest < ServiceError; end
  class Unauthorized < ServiceError; end
  class Forbidden < ServiceError; end
  class NotFound < ServiceError; end
  class InternalServerError < ServiceError; end

  class CSRF < Error
    def initialize(expected = nil, received = nil)
      additional = "Excepted '#{expected}' but received '#{received}'" if expected
      super "Response state did not match sent state. #{additional}."
    end
  end
end
