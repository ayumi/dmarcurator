# frozen_string_literal: true
require File.expand_path("../lib/dmarcurator/version", __FILE__)

Gem::Specification.new do |s|
  s.add_development_dependency "bundler", "~> 1.13"
  s.add_development_dependency "rake"
  s.authors = ["Ayumi Yu"]
  s.description = "Simple tool for viewing DMARC reports"
  s.email = ["ayumi@ayumiyu.com"]
  s.files = `git ls-files`.split("\n")
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.homepage = "https://github.com/ayumi/dmarcurator"
  s.license = "MIT"
  s.name = "dmarcurator"
  s.summary = "Tool for viewing DMARC reports"
  s.require_paths = ["lib"]
  s.version = Dmarcurator::VERSION
end
