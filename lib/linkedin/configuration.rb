module LinkedIn
  module Configuration
    module ClassConfiguration
      BASE_OPTIONS = {
        authorize_path: '/uas/oauth2/authorization',
        access_token_path: '/uas/oauth2/accessToken',
        api_host: 'https://api.linkedin.com',
        auth_host: 'https://www.linkedin.com',
        request_format: :json,

        key: nil,
        secret: nil,
        access_token: nil,

        scope: 'r_basicprofile',
        state: Utils.generate_random_state,
        redirect_uri: 'http://localhost'
      }

      def options
        @options ||= reset
      end

      def reset
        @options = OpenStruct.new BASE_OPTIONS
      end
    end

    module InstanceConfiguration
      def options
        @options ||= reset
      end

      def reset
        @options = self.class.options.clone
      end
    end

    module BaseConfiguration
      def configure(options={}, &block)
        self.options.marshal_load self.options.to_h.merge(options)

        yield self if block_given?

        self.options
      end

      def load(file_path='linkedin.yml')
        config = YAML::load(File.open(file_path)).symbolize_keys
        configure config
      end

      def defaults(*keys)
        options.to_h.slice *keys
      end

      def method_missing(method, *args, &block)
        return self.options.send(method, *args, &block) if self.options.respond_to? method
        super
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
