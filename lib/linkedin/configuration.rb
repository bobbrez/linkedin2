module LinkedIn
  module Configuration
    module ClassConfiguration
      def configuration
        @configuration ||= reset
      end

      def reset
        @configuration = OpenStruct.new default_config
      end
    end

    module InstanceConfiguration
      def configuration
        @configuration ||= reset
      end

      def reset
        @configuration = self.class.configuration.dup
      end
    end

    module BaseConfiguration
      def configure(config={}, &block)
        self.configuration.marshal_load self.configuration.marshal_dump.merge(config)

        yield self.configuration if block_given?

        self.configuration
      end

      def load(file_path='linkedin.yml')
        config = YAML::load(File.open(file_path)).symbolize_keys
        configure config
      end

      def config(*keys)
        configuration.marshal_dump.slice(*keys)
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
