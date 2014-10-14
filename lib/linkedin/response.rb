module LinkedIn
  class Response
    attr_reader :_response, :_body

    def initialize(response)
      @_response = response
      @_body = response.body
    end

    def _status
      _response.status
    end

    def method_missing(method, *args, &block)
      _body.send method, *args, &block
    end
  end
end
