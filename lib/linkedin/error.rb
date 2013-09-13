module LinkedIn
  class Error < StandardError; end
  class CSRF < Error
    def initialize(expected=nil, received=nil)
      additional = "Excepted '#{expected}' but received '#{received}'" if expected
      super "Response state did not match sent state. #{additional}"
    end
  end
end
