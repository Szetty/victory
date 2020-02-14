require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

require "rake/extensiontask"

task :build => :compile

require_relative 'extensions'
extensions.each do |extension|
  Rake::ExtensionTask.new(extension.path) { |ext| ext.name = extension.name }
end

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new

task :default => [:clobber, :compile, :spec, :test]
