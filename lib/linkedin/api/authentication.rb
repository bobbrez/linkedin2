module LinkedIn
  module API
    module Authentication
      def authorize_url(**params)
        params.reverse_merge! configuration.to_h.slice :scope, :state, :redirect_uri
        params[:scope] = serialize_scope params[:scope]
        credentials.auth_code.authorize_url params
      end

      def request_access_token(authorization_code, params = {})
        raise Error::CSRF.new state, params[:state] if params[:state] && params[:state] != state

        params.reverse_merge! redirect_uri: configuration.redirect_uri
        opts = { mode: :query, param_name: 'oauth2_access_token' }

        credentials.auth_code.get_token authorization_code, params, opts
      end

      private

      def serialize_scope(scope)
        Array[scope].flatten.join ' '
      end
    end
  end
end
