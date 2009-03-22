require 'rubygems'
require 'sinatra'
$: << 'lib'
require 'git_wiki'
require 'webapp'

GitWiki.repository_url = ENV['GIT_WIKI_REPO_DIR'] || 'wiki_files'

root_dir = File.dirname(__FILE__)

Sinatra::Application.set(
  :run => false,
  :environment => ENV['RACK_ENV']
)

run Sinatra::Application
