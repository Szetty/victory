require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

require "rake/extensiontask"

task :build => :compile

Rake::ExtensionTask.new('algorithms/string')        { |ext| ext.name = "CString" }
Rake::ExtensionTask.new('containers/deque')         { |ext| ext.name = "CDeque" }
Rake::ExtensionTask.new('containers/bst')           { |ext| ext.name = "CBst" }
Rake::ExtensionTask.new('containers/rbtree_map')    { |ext| ext.name = "CRBTreeMap" }
Rake::ExtensionTask.new('containers/splaytree_map') { |ext| ext.name = "CSplayTreeMap" }
Rake::ExtensionTask.new('containers/xor_list') { |ext| ext.name = 'XORList' }

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new

task :default => [:clobber, :compile, :spec, :test]
