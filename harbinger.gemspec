# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'harbinger/version'

Gem::Specification.new do |spec|
  spec.name          = "harbinger"
  spec.version       = Harbinger::VERSION
  spec.authors       = [
    "Jeremy Friesen"
  ]
  spec.email         = [
    "jeremy.n.friesen@gmail.com"
  ]
  spec.summary       = %q{A Rails engine for arbitrary message creation and delivery.}
  spec.description   = %q{A Rails engine for arbitrary message creation and delivery.}
  spec.homepage      = "https://github.com/jeremyf/harbinger"
  spec.license       = "Apache2"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec-given"
  spec.add_development_dependency "engine_cart"
  spec.add_development_dependency "rails", "~> 4.0"

end
