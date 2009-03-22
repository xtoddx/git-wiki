begin
  require 'test/spec'
  require 'sinatra/test'
rescue LoadError => e
  require 'rubygems'
  require 'test/spec'
  require 'sinatra/test'
end

$: << 'lib'
require 'webapp'

GitWiki.repository_url = "test/test_wiki"
