module LinkedIn
  class Credentials
    extend Forwardable

    def_delegators :client, :auth_code

    def initialize(configuration)
      @configuration = configuration
    end

    def type
      :oauth2
    end

    def client
      @client ||= OAuth2::Client.new @configuration.key, @configuration.secret, oauth2_options
    end

    private

    def oauth2_options
      { site:          'https://api.linkedin.com',
        authorize_url: 'https://www.linkedin.com/uas/oauth2/authorization',
        token_url:     'https://www.linkedin.com/uas/oauth2/accessToken' }
    end
  end
end
