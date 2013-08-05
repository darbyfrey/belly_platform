module BellyPlatform
  class Middleware
    class Logger
      def initialize(app)
        @app = app
      end

      def call(env)
        # set transaction_id
        transaction_id=SecureRandom.uuid

        # log the request
        BellyPlatform::Logger.logger.debug format_request(env)

        # process the request
        status, headers, body = @app.call(env)

        # log the response
        BellyPlatform::Logger.logger.debug format_response(status, headers, body)

        # return the results
        [status, headers, body]
      ensure
        # Clear the transaction id after each request
        BellyPlatform::LogTransaction.clear
      end

    private
      def format_request(env)
        request = Rack::Request.new(env)

        request_data = {
          method:           env['REQUEST_METHOD'],
          path:             env['PATH_INFO'],
          query:            env['QUERY_STRING'],
          host:             BellyPlatform::Identity.hostname,
          pid:              BellyPlatform::Identity.pid,
          revision:         BellyPlatform::Identity.revision,
          params:           request.params
        }
        request_data[:user_id] = current_user.try(:id) if defined?(current_user)
        {request: request_data}
      end

      def format_response(status, headers, body)
        response_body = nil
        begin
          response_body = body.respond_to?(:body) ? body.body.map{|r| r} : nil
        rescue
          response_body = body.inspect
        end
        
        {response:
          {
            status:   status,
            headers:  headers,
            response: response_body
          }
        }
      end
    end
  end
end
