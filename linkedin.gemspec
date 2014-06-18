# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'linkedin/version'

Gem::Specification.new do |spec|
  spec.name          = 'linkedin2'
  spec.version       = LinkedIn::VERSION
  spec.authors       = ['Bob Breznak', 'Josh Jordan']
  spec.email         = ['bob@evertrue.com', 'josh.jordan@gmail.com']
  spec.description   = %q{Ruby wrapper for the LinkedIn API}
  spec.summary       = %q{Ruby wrapper for the LinkedIn API}
  spec.homepage      = 'https://github.com/bobbrez/linkedin2'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'oauth2', '~> 0.9'
  spec.add_dependency 'hashie', '> 2.1.1'
  spec.add_dependency 'activesupport', '>= 3.2'
  spec.add_dependency 'faraday_middleware', '~> 0.9.1'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'rspec', '~> 2.14'
  spec.add_development_dependency 'vcr', '~> 2.5'
  spec.add_development_dependency 'yard'
end
