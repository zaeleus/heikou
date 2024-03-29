# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'heikou/version'

Gem::Specification.new do |gem|
  gem.name          = 'heikou'
  gem.version       = Heikou::VERSION
  gem.authors       = ['Michael Macias']
  gem.email         = ['mamacias@olemiss.edu']
  gem.summary       = %q{Gratuitous amount of heterogeneous computing}
  gem.homepage      = 'https://github.com/zaeleus/heikou'

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.required_ruby_version = '>= 1.9.2'

  gem.add_development_dependency 'rspec', '~> 2.11.0'

  gem.add_dependency 'ffi', '~> 1.2.0'
end
