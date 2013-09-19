module LinkedIn
  class Error < StandardError
    attr_accessor :status, :body

    def initialize(error_data={})
      super error_data

      if hash = Hash.try_convert(error_data)
        self.status, self.body = hash[:status], hash[:body]
      end
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
