require 'erb'
db = YAML.load(ERB.new(File.read('./config/mysql.yml')).result)[RACK_ENV]
ActiveRecord::Base.establish_connection(db)
ActiveRecord::Base.logger = BellyPlatform::Logger.logger if RACK_ENV == 'development'
