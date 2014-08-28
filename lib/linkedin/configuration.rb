module LinkedIn
  module Configuration
    module ClassConfiguration
      def default_config
        {
          request_format: :json,

          app_key: nil,
          app_secret: nil,
          access_token: nil,

          scope: ['r_basicprofile'],
          redirect_uri: 'http://localhost',

          logger: Logger.new('/dev/null')
        }
      end

      def configuration
        @configuration ||= OpenStruct.new default_config
        self
      end

      def reset
        configuration.marshal_load default_config
      end
    end

    module InstanceConfiguration
      def configuration
        @configuration ||= self.class.configuration.dup
        self
      end

      def reset
        @configuration.marshal_load self.class.configuration
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
