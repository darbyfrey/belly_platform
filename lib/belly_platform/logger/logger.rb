module BellyPlatform
  class Logger
    class << self
      def name
        [BellyPlatform::Identity.name, BellyPlatform::LogTransaction.id].join('-')
      end

      def logger=(logger)
        @logger = logger
      end

      def logger
        unless @logger
          Logging.appenders.stdout(
            'stdout',
            :layout => Logging.layouts.json
          )
          Logging.appenders.file(
            "log/#{ENV['RACK_ENV']}.log",
            :layout => Logging.layouts.json
          )

          @logger = Logging.logger["[#{name}]"]
          unless ENV['RACK_ENV'] == 'test'
            @logger.add_appenders 'stdout'
          end
          @logger.add_appenders "log/#{ENV['RACK_ENV']}.log"
        end

        @logger
      end
    end
  end
end
