#!/usr/bin/env ruby

require 'rubygems'
require 'sinatra'
$: << 'lib'
require 'git_wiki'
require 'webapp'

GitWiki.repository_url = ENV['GIT_WIKI_REPO_DIR'] || '../gw_files'
if ENV['GIT_WIKI_REPO_BRANCH']
  GitWiki.repository_branch = ENV['GIT_WIKI_REPO_BRANCH']
end

root_dir = File.dirname(__FILE__)

Sinatra::Application.set(
  :run => false,
  :environment => ENV['RACK_ENV']
)

Webapp.run!
