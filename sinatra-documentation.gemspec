# -*- encoding: utf-8 -*-
require File.expand_path('../lib/sinatra/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Justin Smestad"]
  gem.email         = ["justin.smestad@gmail.com"]
  gem.description   = %q{Tools for creating a simple web API}
  gem.summary       = %q{Tools for creating a simple web API}
  gem.homepage      = "https://github.com/jsmestad/sinatra-documentation"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "sinatra-documentation"
  gem.require_paths = ["lib"]
  gem.version       = Sinatra::Documentation::VERSION

  gem.add_dependency 'redcarpet'
  gem.add_dependency 'sinatra'
  gem.add_dependency 'sinatra-contrib'
  gem.add_dependency 'tilt'

  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'shotgun'
end
