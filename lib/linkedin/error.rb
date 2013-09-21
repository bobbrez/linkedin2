module LinkedIn
  class Error < StandardError
    extend Forwardable

    attr_accessor :request, :response
    delegate [:status, :body] => :response

    def initialize(error_data={})
      if hash = Hash.try_convert(error_data)
        self.request, self.response = hash[:request], hash[:response]
      end

      super (self.response && self.response.body['message']) || error_data
    end
  end

  class BadRequest < Error; end
  class Unauthorized < Error; end
  class Forbidden < Error; end
  class NotFound < Error; end
  class InternalServerError < Error; end

  class CSRF < Error
    def initialize(expected=nil, received=nil)
      additional = "Excepted '#{expected}' but received '#{received}'" if expected
      super "Response state did not match sent state. #{additional}"
    end
  end
end
