# require external libraries
require 'rake'
require 'dotenv'
require 'logging'
require 'octokit'
require 'grape'

# require internal files
require "belly_platform/version"
require "belly_platform/logger/logger"
require "belly_platform/logger/log_transaction"
require "belly_platform/identity"
require "belly_platform/middleware/logger"
require "belly_platform/middleware/app_monitor"
require "belly_platform/grape_api"
require "generators/scaffold"

# load rake tasks if Rake installed
if defined?(Rake)
	load 'tasks/git.rake'
  load 'tasks/deploy.rake'
  load 'tasks/routes.rake'
end


module BellyPlatform
  class << self
    def env
      @_env ||= ActiveSupport::StringInquirer.new(ENV["RACK_ENV"] || "development")
    end

    def env=(environment)
      @_env = ActiveSupport::StringInquirer.new(environment)
    end
  end
end
