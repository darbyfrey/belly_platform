module BellyPlatform
  class Logger
    class << self
      def logger=(logger)
        @logger = logger
      end

      def logger
        unless @logger
          Logging.appenders.stdout(
            'stdout',
            :layout => Logging.layouts.pattern(
              :format_as => :json,
              :pattern => '[%d] %-5l %c: %m\n',
            )
          )

          @logger = Logging.logger["[#{BellyPlatform::Identity.name}]"]
          @logger.add_appenders 'stdout'
        end

        @logger
      end
    end
  end
end
