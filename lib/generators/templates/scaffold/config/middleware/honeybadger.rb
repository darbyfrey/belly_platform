Honeybadger.configure do |config|
  config.environment_name = BellyPlatform.env
  config.api_key = ENV['HONEYBADGER_API_KEY']
end
