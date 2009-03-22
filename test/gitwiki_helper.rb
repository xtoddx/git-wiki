begin
  require 'test/spec'
rescue LoadError => e
  require 'rubygems'
  gem 'test-spec'
  require 'test/spec'
end

$: << 'lib'
require 'git_wiki'
