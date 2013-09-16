require './app'

# use Rack::Cors do
#   allow do
#     origins '*'
#     resource '*', headers: :any, methods: :any
#   end
# end
# 
# use Honeybadger::Rack
# use BellyPlatform::Middleware::Logger

use BellyPlatform::Middleware::AppMonitor

# run SomeService # <-- boot your service here --
  
