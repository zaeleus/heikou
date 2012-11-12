# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'opencl/version'

Gem::Specification.new do |gem|
  gem.name          = 'ffi-opencl'
  gem.version       = OpenCL::VERSION
  gem.authors       = ['Michael Macias']
  gem.email         = ['mamacias@olemiss.edu']
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.required_ruby_version = '>= 1.9.2'

  gem.add_development_dependency 'rspec', '~> 2.11.0'

  gem.add_dependency 'ffi', '1.2.0.pre3'
end
