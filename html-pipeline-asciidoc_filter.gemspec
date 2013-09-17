# -*- encoding: utf-8 -*-
require File.expand_path '../lib/html/pipeline/asciidoc_filter/version', __FILE__

Gem::Specification.new do |gem|
  # named according to http://guides.rubygems.org/name-your-gem
  gem.name          = 'html-pipeline-asciidoc_filter'
  gem.version       = HTML_Pipeline::AsciiDocFilter::VERSION
  gem.authors       = ['Dan Allen']
  gem.email         = ['dan.j.allen@gmail.com']
  gem.summary       = %(An AsciiDoc filter for html-pipeline based on Asciidoctor)
  gem.description   = %(An AsciiDoc filter for html-pipeline based on Asciidoctor)
  gem.homepage      = 'https://github.com/asciidoctor/html-pipeline-asciidoc_filter'
  gem.license       = 'MIT'

  gem.files         = `git ls-files -z -- */* {README,LICENSE}* *.gemspec`.split("\0")
  gem.executables   = gem.files.grep(%r"^bin/") { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r"^test/")
  gem.require_paths = ['lib']

  gem.add_dependency 'html-pipeline', '~> 0.3'
  gem.add_dependency 'asciidoctor', '= 0.1.4'

  # activesupport should be a dependency of html-pipeline; cannot it load html-pipeline without it
  gem.add_development_dependency 'activesupport', RUBY_VERSION < '1.9.3' ? ['>= 2', '< 4'] : '>= 2'

  gem.add_development_dependency 'bundler', '~> 1.3'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'github-linguist', '~> 2.6.2'
end
