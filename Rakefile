require 'bundler/gem_tasks'
require 'rake/testtask'

# NOTE can't rely on gemspec since it only honors committed test files
# so an explicit definition is required
Rake::TestTask.new do |t|
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
  #t.warning = true
end

task :default => :test
