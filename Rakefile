require File.expand_path '../lib/html/pipeline/asciidoc_filter/version', __FILE__

require 'bundler/gem_tasks'
require 'rake/testtask'

# Enhance the release task to create an explicit commit for the release
Rake::Task[:release].enhance [:commit_release]

# NOTE you don't need to push after updating version and committing locally
task :commit_release do
  Bundler::GemHelper.new.send(:guard_clean)
  sh "git commit --allow-empty -a -m 'Release #{HTML_Pipeline::AsciiDocFilter::VERSION}'"
end

# NOTE can't rely on gemspec since it only honors committed test files
# so an explicit definition is required
Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
  #t.warning = true
end

task :default => :test
