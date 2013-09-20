module LinkedIn
  module Configuration
    module ClassConfiguration
      def config
        @config ||= reset
      end

      def reset
        @config = OpenStruct.new default_config
      end
    end

    module InstanceConfiguration
      def config
        @config ||= reset
      end

      def reset
        @config = self.class.config.dup
      end
    end

    module BaseConfiguration
      def configure(config={}, &block)
        self.config.marshal_load self.config.to_h.merge(config)

        yield self if block_given?

        self.config
      end

      def load(file_path='linkedin.yml')
        config = YAML::load(File.open(file_path)).symbolize_keys
        configure config
      end

      def defaults(*keys)
        config.to_h.slice *keys
      end
    end

    include BaseConfiguration
    include InstanceConfiguration

    def self.included(klass)
      klass.extend BaseConfiguration
      klass.extend ClassConfiguration
    end
  end
end
