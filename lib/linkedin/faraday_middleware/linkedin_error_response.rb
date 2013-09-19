module LinkedIn
  module FaradayMiddleware
    class LinkedinErrorResponse < Faraday::Response::Middleware
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

        raise error.new response_values(env) if status >= 400
      end

      def response_values(env)
        { status: env[:status], body: env[:body] }
      end
    end
  end
end

