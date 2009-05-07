##
# GitWiki is the library to store your wiki in a git repository.
#
module GitWiki
  class << self
    attr_accessor :repository_url
    attr_accessor :repository_branch
    def repository_url
      @repository_url || Dir.pwd
    end
    def repository_branch
      @repository_branch || 'master'
    end
  end
end

require 'git_wiki/repository'
require 'git_wiki/git_resource'
require 'git_wiki/page'
require 'git_wiki/layout'
require 'git_wiki/view'

