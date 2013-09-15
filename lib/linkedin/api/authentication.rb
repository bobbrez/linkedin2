module LinkedIn
  module API
    module Authentication
      attr_reader :state

      def authorize_url(params={})
        params.reverse_merge! defaults(:scope, :state, :redirect_uri)
        auth_code.authorize_url params
      end

      def request_access_token(authorization_code, params={})
        raise Error::CSRF.new state, params[:state] if params[:state] && params[:state] != state

        params.reverse_merge! defaults(:redirect_uri)
        opts = { mode: :query, param_name: 'oauth2_access_token' }

        self.access_token = auth_code.get_token authorization_code, params, opts
      end

    end
  end
end
