# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dciablo/version'

Gem::Specification.new do |spec|
  spec.name          = "dciablo"
  spec.version       = Dciablo::VERSION
  spec.authors       = ["Alexei Lexx"]
  spec.email         = ["alexei.lexx@gmail.com"]
  spec.summary       = %q{Implementation of DCI patter in Ruby}
  spec.description   = %q{Implementation of DCI patter in Ruby}
  spec.homepage      = "https://github.com/alexei-lexx/dciablo"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2.0"
end
