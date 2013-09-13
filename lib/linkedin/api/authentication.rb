module LinkedIn
  module API
    module Authentication
      attr_reader :state
      attr_accessor :access_token

      def authorize_url(params={})
        params.reverse_merge! options.to_h.slice(:scope, :state, :redirect_uri)
        auth_code.authorize_url params
      end

      def request_access_token(authorization_code, params={})
        raise Error::CSRF.new state, params[:state] if params[:state] && params[:state] != state

        params.reverse_merge! options.to_h.slice(:redirect_uri)
        opts = { mode: :query, param_name: 'oauth2_access_token' }

        token_response = auth_code.get_token authorization_code, params, opts
        self.access_token = token_response.token
      end
    end
  end
end
