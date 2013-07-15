# require external libraries
require 'rake'
require 'dotenv'
require 'logging'
require 'octokit'
require 'grape'

# require internal files
require "belly_platform/version"
require "belly_platform/logger"
require "belly_platform/identity"
require "belly_platform/middleware/logger"
require "belly_platform/grape_api"

# load rake tasks if Rake installed
if defined?(Rake)
	load 'tasks/git.rake'
  load 'tasks/deploy.rake'
  load 'tasks/routes.rake'
end


module BellyPlatform
end
