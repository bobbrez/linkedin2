module LinkedIn
  class Response
    extend Forwardable

    def_delegators :source, :[]

    attr_reader :raw

    def initialize(raw)
      @raw = raw
    end

    def source
      raw.body
    end
  end
end
