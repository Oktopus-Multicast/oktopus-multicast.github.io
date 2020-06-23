# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "oktopus"
  spec.version       = "0.1"

  spec.summary       = %q{Oktopus documention.}
  spec.homepage      = "https://github.com/pmarsceill/just-the-docs"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").select { |f| f.match(%r{^(assets|bin|_layouts|_includes|lib|Rakefile|_sass|LICENSE|README)}i) }
  spec.executables   << 'oktopus'
  
  spec.add_runtime_dependency "bundler", "~> 2.0.2"
  spec.add_runtime_dependency "jekyll", ">= 3.8", "< 4.1.0"
  spec.add_runtime_dependency "jekyll-seo-tag", "~> 2.0"
  spec.add_runtime_dependency "rake", ">= 12.3.1", "< 13.1.0"
  spec.add_runtime_dependency 'jekyll-environment-variables'


end
