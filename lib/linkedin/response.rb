module LinkedIn
  class Response < Hashie::Mash
    attr_reader :_response

    def initialize(response)
      super response.body
      @_response = response
    end

    def method_missing(method, *args, &block)
      case method.to_s
      when /^_(.+)/
        _response.send $1.to_sym, *args, &block
      else
        super
      end
    end
  end
end
