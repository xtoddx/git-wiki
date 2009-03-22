require 'rubygems'
require 'sinatra'
$: << 'lib'
require 'git_wiki'
require 'webapp'

root_dir = File.dirname(__FILE__)

Sinatra::Application.set(
  :run => false,
  :environment => ENV['RACK_ENV']
)

run Sinatra::Application
