# -*- encoding: utf-8 -*-
require File.expand_path('../lib/belly_platform/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Darby Frey"]
  gem.email         = ["darby@bellycard.com"]
  gem.description   = %q{Common functionality for the BellyPlatform}
  gem.summary       = %q{Common functionality for the BellyPlatform}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   << 'belly_platform'
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "belly_platform"
  gem.require_paths = ["lib"]
  gem.version       = BellyPlatform::VERSION


  gem.add_dependency 'rake'
  gem.add_dependency 'logging'
  gem.add_dependency 'dotenv'
  gem.add_dependency 'octokit'
  gem.add_dependency 'grape'
  gem.add_dependency 'grape-swagger'

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "pry"
  gem.add_development_dependency "git"
end
