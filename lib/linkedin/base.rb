module LinkedIn
  class Base
    attr_reader :attributes

    include Configuration

    def initialize(attributes={})
      @attributes = Hashie::Mash.new attributes
    end

    def client
      config.client
    end

    def method_missing(method, *args, &block)
      return @attributes.send(method, *args, &block) if @attributes.respond_to?(method)
      super
    end

    def respond_to?(method, include_all=false)
      return true if @attributes.respond_to method, include_all
      super
    end

    def self.client
      config.client
    end

    def self.default_config
      { client: LinkedIn::Client.new }
    end
  end
end
