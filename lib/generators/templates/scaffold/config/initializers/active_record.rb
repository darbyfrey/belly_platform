require 'erb'
db = YAML.load(ERB.new(File.read('./config/database.yml')).result)[BellyPlatform.env]
ActiveRecord::Base.establish_connection(db)
ActiveRecord::Base.logger = BellyPlatform::Logger.logger if BellyPlatform.env.development?
