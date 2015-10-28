# -*- encoding: utf-8 -*-
require File.expand_path '../lib/html/pipeline/asciidoc_filter/version', __FILE__

Gem::Specification.new do |gem|
  # named according to http://guides.rubygems.org/name-your-gem
  gem.name          = 'html-pipeline-asciidoc_filter'
  gem.version       = HTML_Pipeline::AsciiDocFilter::VERSION
  gem.authors       = ['Dan Allen']
  gem.email         = ['dan.j.allen@gmail.com']
  gem.summary       = 'An AsciiDoc processing filter for html-pipeline powered by Asciidoctor'
  gem.description   = 'An AsciiDoc processing filter for html-pipeline powered by Asciidoctor'
  gem.homepage      = 'https://github.com/asciidoctor/html-pipeline-asciidoc_filter'
  gem.license       = 'MIT'

  gem.files         = `git ls-files -z -- */* {README,LICENSE}* *.gemspec`.split("\0")
  gem.executables   = gem.files.grep(/^bin\//) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(/^test\//)
  gem.require_paths = ['lib']

  gem.add_dependency 'html-pipeline', '~> 2.2'
  gem.add_dependency 'asciidoctor', '~> 1.5.2'
end
