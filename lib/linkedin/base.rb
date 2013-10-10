module LinkedIn
  class Base
    attr_reader :attributes

    def initialize(attributes={})
      @attributes = Hashie::Mash.new attributes
    end


    def method_missing(method, *args, &block)
      return @attributes.send(method, *args, &block) if @attributes.respond_to?(method)
      super
    end

    def respond_to?(method, include_all=false)
      return true if @attributes.respond_to method, include_all
      super
    end

    def client
      LinkedIn.new
    end

    def self.client
      LinkedIn.new
    end
  end
end
