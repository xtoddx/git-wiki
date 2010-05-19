begin
  require 'test/spec'
  require 'rack/test'
rescue LoadError => e
  require 'rubygems'
  require 'test/spec'
  require 'rack/test'
end

$: << 'lib'
require 'webapp'
Webapp

GitWiki.repository_url = "test/test_wiki"
GitWiki.repository_branch = "test_in_progress"

module WebappHelper
  def app
    Webapp.new
  end
end
