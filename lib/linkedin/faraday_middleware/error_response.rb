module LinkedIn
  module FaradayMiddleware
    class ErrorResponse < Faraday::Response::Middleware
      ERRORS = {
        400 => BadRequest,
        401 => Unauthorized,
        403 => Forbidden,
        404 => NotFound,
        500 => InternalServerError
      }

      def on_complete(env)
        status = env[:status].to_i
        error = ERRORS[status] || Error

        raise error.new Hashie::Mash.new(env) if status >= 400
      end
    end
  end
end
