# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'headache/version'

Gem::Specification.new do |spec|
  spec.name          = 'headache'
  spec.version       = Headache::VERSION
  spec.authors       = ['Payoff, Inc.', 'Chris Bielinski']
  spec.email         = ['engineering@payoff.com', 'cbielinski@payoff.com']

  spec.summary       = 'Take the pain out of building ACH files'
  spec.description   = 'Take the pain out of building ACH files'
  spec.homepage      = 'https://github.com/teampayoff/headache'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'fixy'
  spec.add_dependency 'activesupport', '~> 4'

  spec.add_development_dependency 'faker'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'factory_girl'
  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
end
