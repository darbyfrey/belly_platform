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
        BellyPlatform::Logger.logger.debug format_request(env, transaction_id)

        # process the request
        status, headers, body = @app.call(env)

        # log the response
        BellyPlatform::Logger.logger.debug format_response(transaction_id, status, headers, body)

        # return the results
        [status, headers, body]
      end

    private
      def format_request(env, transaction_id)
        request = Rack::Request.new(env)

        request_data = {
          transaction_id:   transaction_id,
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

      def format_response(transaction_id, status, headers, body)
        response_body = nil
        begin
          response_body = body.respond_to?(:body) ? body.body.map{|r| JSON.parse(r)} : nil
        rescue
          response_body = body.inspect
        end
        
        {response:
          {
            transaction_id:   transaction_id,
            status:   status,
            headers:  headers,
            response: response_body
          }
        }
      end
    end
  end
end
