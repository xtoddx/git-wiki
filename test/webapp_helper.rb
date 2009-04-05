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
GitWiki.repository_branch = "test_in_progress"

module WebappHelper
  def self.included kls
    prk = proc{ @app = Webapp }
    kls.send :setup, &prk
  end
end
