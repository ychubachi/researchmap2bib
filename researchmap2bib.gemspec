# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'researchmap2bib/version'

Gem::Specification.new do |spec|
  spec.name          = "researchmap2bib"
  spec.version       = Researchmap2bib::VERSION
  spec.authors       = ["Yoshihide Chubachi"]
  spec.email         = ["yoshi@chubachi.net"]

  spec.summary       = %q{Create LaTeX bibliography files from the XML exported file form researchmap.}
  spec.description   = %q{This script creates bibliography files which can be used by LaTeX from researchmap.}
  spec.homepage      = "https://github.com/ychubachi/researchmap2bib"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry"
end
