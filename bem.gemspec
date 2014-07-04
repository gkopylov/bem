# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bem/version'

Gem::Specification.new do |spec|
  spec.name          = 'bem'
  spec.version       = Bem::VERSION
  spec.authors       = ['Kopylov German']
  spec.email         = ['roverrr@gmail.com']
  spec.summary       = 'Ruby library for working with BEM in rails projects'
  spec.description   = 'Ruby library for working with BEM in rails projects'
  spec.homepage      = 'https://github.com/gkopylov/bem'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'thor'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rails'
end
