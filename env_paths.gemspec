lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'env_paths/version'

Gem::Specification.new do |spec|
  spec.name          = 'env_paths'
  spec.version       = EnvPaths::VERSION
  spec.authors       = ['Nick Tomlin']
  spec.email         = ['nick.tomlin@gmail.com']
  spec.summary       = 'Environment specific paths. A port of node\'s env-paths'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.5'
  spec.add_development_dependency 'rubocop', '~> 0.51.0'
end
