require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

task :default => :test

desc "Run tests"
task :test do
  errors = ['test:git_wiki', 'test:webapp'].collect do |t|
    begin
      Rake::Task[t].invoke
      nil
    rescue => e
      t
    end
  end
  errors.compact!
  abort "Testing failed on: #{errors.inspect}" unless errors.empty?
end

desc "Create Docs"
task :doc do
  errors = ['doc:git_wiki', 'doc:webapp'].collect do |t|
    begin
      Rake::Task[t].invoke
      nil
    rescue => e
      t
    end
  end
  errors.compact!
  abort "Doc failed on: #{errors.inspect}" unless errors.empty?
end

desc "Remove Docs and Test Artifacts"
task :clean do |t|
  sh "rm -rf doc"
end

namespace :test do
  Rake::TestTask.new(:git_wiki) do |t|
    t.pattern  ='test/git_wiki/*.rb'
    t.verbose = true
  end
  Rake::Task['test:git_wiki'].comment = "Test the git_wiki libraries"

  Rake::TestTask.new(:webapp) do |t|
    t.pattern  ='test/webapp/*.rb'
    t.verbose = true
  end
  Rake::Task['test:webapp'].comment = "Test the webapp"
end

namespace :doc do
  Rake::RDocTask.new(:git_wiki) do |t|
    t.rdoc_dir = 'doc/git_wiki'
    t.title = 'Git Wiki'
    t.options << '--line-numbers' << '--inline-source'
    t.rdoc_files.include('lib/git_wiki.rb')
    t.rdoc_files.include('lib/git_wiki/**/*.rb')
  end
  Rake::Task['doc:git_wiki'].comment = "Document the git_wiki libraries"

  Rake::RDocTask.new(:webapp) do |t|
    t.rdoc_dir = 'doc/webapp'
    t.title = 'Git Wiki (Sinatra App)'
    t.options << '--line-numbers' << '--inline-source'
    t.rdoc_files.include('lib/webapp.rb')
    t.rdoc_files.include('lib/webapp/**/*.rb')
  end
  Rake::Task['doc:webapp'].comment = "Document the sinatra app"
end

