# BellyPlatform

The BellyPlatform gem provides a set of common features used by various Belly services. These features include:

* Identity
* Logging
* Deployment
* Grape Specific Features (Cache management and Route inspection)

## Installation

Add this line to your application's Gemfile:

    gem 'belly_platform', :git => 'https://github.com/bellycard/belly_platform.git'

And then execute:

    $ bundle

### First time notes

If you havent installed the gem before, and you want to use the built in generator for your first project.  You can use `gem` to install  from our github repository by executing:

    $ git clone git@github.com:bellycard/belly_platform.git && cd belly_platform
    $ gem build belly_platform.gemspec
    $ sudo gem install belly_platform-0.0.version_number.gem

## Getting started, an example

This gem comes with a useful generator to stub out your projects folder structure.

    $ belly_platform new your_project_name

There are no default APIs, so you will have to add one.  Create a new file in the /app/apis folder, name this file `hello.rb` and define the following class within it. This will be our first endpoint.

```ruby
// /app/apis/hello.rb
class HelloApi < Grape::API
  desc "a hello world API endpoint"
  get do
    {cheery_message: "hello wonderful world"}
  end
end
```

Every API should have a coresponding spec. Create a file named `hello_api_spec.rb` under /spec/apis (you will need to create the 'apis' folder) and define the following class within it.

```ruby
// /spec/apis/hello_api_spec.rb
require 'spec_helper'

describe HelloApi do
  include Rack::Test::Methods

  def app
    HelloApi
  end

  describe 'Get /hello' do

    before do
      get '/hello'
    end

    it 'returns a cheery message' do
      expect(last_response.body).to eq({cheery_message: "hello wonderful world"}.to_json)
    end

  end

end
```

Now open `app.rb` and define your service by adding the following class to the end of the file

```ruby
// add this to the end of /app.rb
class HelloWorldService < Grape::API
  format :json

  mount HelloApi => 'hello'
end
```

The last step is to update your `config.ru` file to identify which service to boot.  Add the following line to the end of `config.ru`

    run HelloWorldService

To check your tests pass, execute:

    $ rspec

To run your service, execute:

    $ rackup

When you visit http://localhost:9292/hello you should now be presented with your first JSON response.

## Usage/Features

### Identity
The *Identity* module exists to provide and interface to get information about the application. For example:

`BellyPlatform::Identity.name` => Returns the name of the app defined by `ENV['SERVICE_NAME']`.

`BellyPlatform::Identity.hostname` => Returns the name of the host running the application.

`BellyPlatform::Identity.revision` => Returns the current revision from Git.

`BellyPlatform::Identity.pid` => Returns the current running process id.

### Logger
The *Logger* modules is used to create a common log format across applications. The Logger is enable via a rack middleware by adding the line below to your `config.ru` file:

```ruby
use BellyPlatform::Middleware::Logger
```

You can also enable the logger for ActiveRecord by adding the following line to an initializer:

```ruby
ActiveRecord::Base.logger = BellyPlatform::Logger.logger
```

`BellyPlatform::Logger.logger` returns a Singleton instance of the Logging object, so it can be passed to other libraries or called directly. For example:

```ruby
BellyPlatform::Logger.logger.debug 'Some Debug Message'
```

### Deployment
At Belly we leverage a git based deployment process, so we've included some rake tasks we use to automate deployments. These tasks will essentially just tag a commit with `production` or `staging` so that it can be picked up by a separate deployment process.

The tasks currently available are:

```ruby
rake deploy:staging
```


```ruby
rake deploy:production
```

**Please Note:** These tasks rely on two environment variables - `GITHUB_OAUTH_TOKEN` and `GITHUB_REPO`. For more information, see **Environment Variables** below. 

### Grape Specific Features
At Belly we use the [Grape Micro-Framework](https://github.com/intridea/grape) for many services, so we've included a few common features.

#### Cache Managment
Cache control headers are sent with Grape API responses to prevent clients from caching responses unexpectedly. This feature is enabled by default, so you don't have to make any changes to enable it.

#### Route Inspection
A rake task is included to give you a Rails style list of your routes. Simpley run:

```ruby
rake routes
```

### Environment Variables
The BellyPlatform expects to find some environment variables set in your application in order for some features to work. A list is below:

#### SERVICE_NAME
The name of your app or service, used by Identity and as a label for your logs

#### GITHUB\_OAUTH\_TOKEN
Used to grant access to your application on Github for deployment tagging

#### GITHUB_REPO
Your application's Github repo. i.e. `bellycard/belly_platform`

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## Todo/Feature Requests

* Add specs for logger and logging middleware