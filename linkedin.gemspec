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

  spec.add_dependency 'oauth2', '~> 1.0'
  spec.add_dependency 'hashie', '> 2.1.1'
  spec.add_dependency 'activesupport', '>= 3.2'
  spec.add_dependency 'faraday_middleware', '~> 0.9.1'

  spec.add_development_dependency 'dotenv', '~> 0.11.1'

  spec.add_development_dependency 'bundler', '~> 1.6'
  spec.add_development_dependency 'rake', '~> 10.0'

  spec.add_development_dependency 'pry', '~> 0.10.0'
  spec.add_development_dependency 'pry-byebug', '~> 1.3.3'

  spec.add_development_dependency 'rspec', '~> 3.0.0'
  spec.add_development_dependency 'rspec-collection_matchers', '1.0.0'
  spec.add_development_dependency 'webmock', '~> 1.18.0'
  spec.add_development_dependency 'simplecov', '~> 0.9.0'
  spec.add_development_dependency 'coveralls', '~> 0.7.1'
  spec.add_development_dependency 'vcr', '~> 2.5'

  spec.add_development_dependency 'yard'
end
