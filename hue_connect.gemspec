# -*- encoding: utf-8 -*-
require File.expand_path('../lib/hue_connect/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Dennis Kuczynski"]
  gem.email         = ["dennis.kuczynski@gmail.com"]
  gem.description   = %q{Simple Sinatra endpoint for controlling Phillips Hue lights}
  gem.summary       = %q{Simple Sinatra endpoint for controlling Phillips Hue lights}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "hue_connect"
  gem.require_paths = ["lib"]
  gem.version       = HueConnect::VERSION
  
  gem.add_dependency "sinatra",         ">= 1.3.0"
  gem.add_dependency "sinatra-contrib", ">= 1.3.0"
  gem.add_dependency "sinatra-assetpack", ">= 0.0.11"
  gem.add_dependency "json"

  gem.add_development_dependency "rake"
  gem.add_development_dependency "rack-test"
  gem.add_development_dependency "rspec"
  gem.add_development_dependency "capybara"

  # For Rails integration testing
  gem.add_development_dependency "rails"
end
