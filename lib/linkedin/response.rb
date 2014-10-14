module LinkedIn
  class Response
    attr_reader :_response

    def initialize(response)
      @_response = response
      @body = response.body
    end

    def _status
      _response.status
    end

    def method_missing(method, *args, &block)
      _response.body.send method, *args, &block
    end
  end
end
