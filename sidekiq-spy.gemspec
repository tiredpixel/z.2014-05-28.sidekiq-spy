# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sidekiq-spy/version'

Gem::Specification.new do |spec|
  spec.name          = "sidekiq-spy"
  spec.version       = SidekiqSpy::VERSION
  spec.authors       = ["tiredpixel"]
  spec.email         = ["tp@tiredpixel.com"]
  spec.description   = %q{Sidekiq monitoring in the console. A bit like Sidekiq::Web. But without the web.}
  spec.summary       = %q{Sidekiq monitoring in the console.}
  spec.homepage      = "https://github.com/tiredpixel/sidekiq-spy"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "sidekiq", "~> 3.2"
  spec.add_dependency "curses", ">= 1.0.1"

  spec.add_development_dependency "bundler", "~> 1.3", "!= 1.5.0"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "mocha", "~> 0.14"
end
