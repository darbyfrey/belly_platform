module BellyPlatform
  class Identity
    def self.name
      ENV['SERVICE_NAME'] || 'api-service'
    end

    def self.hostname
      @hostname ||= `hostname`.strip
    end

    def self.revision
      @revision ||= `git rev-parse HEAD`.strip
    end

    def self.pid
      @pid ||= Process.pid
    end
  end
end
