module BellyPlatform
  class LogTransaction
    class << self
      def id
        Thread.current[:belly_tid].nil? ? Thread.current[:belly_tid] = SecureRandom.hex(10) : Thread.current[:belly_tid]
      end

      def id=(id)
        Thread.current[:belly_tid] = id
      end

      def clear
        Thread.current[:belly_tid] = nil
      end
    end
  end
end