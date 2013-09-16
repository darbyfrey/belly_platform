module BellyPlatform
  class Middleware
    class AppMonitor
      def initialize(app)
        @app = app
      end

      def call(env)
        if env['REQUEST_URI'] == '/health'
          [200, {'Content-type' => 'application/json'}, [BellyPlatform::Identity.health.to_json]]
        else
          @app.call(env)
        end
      end
    end
  end
end