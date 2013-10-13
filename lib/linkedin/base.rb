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
      Base.client
    end

    def self.client
      @@client ||= self.reset_client
    end

    def self.reset_client
      @@client = LinkedIn.new
    end
  end
end
