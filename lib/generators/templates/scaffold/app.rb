# load bundler
Bundler.setup(:default)
require 'belly_platform'
Bundler.require(:default, BellyPlatform.env.to_sym)
require 'will_paginate'
require 'will_paginate/active_record' 

# load environment
Dotenv.load(BellyPlatform.env.test? ? ".env.test" : ".env")

# autoload lib
Dir['./lib/**/**/*.rb'].map {|file| require file }

# autoload initalizers
Dir['./config/initializers/**/*.rb'].map {|file| require file }

# load middleware configs
Dir['./config/middleware/**/*.rb'].map {|file| require file }

# autoload app
Dir['./app/**/**/*.rb'].map {|file| require file }
