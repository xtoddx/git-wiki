##
# GitWiki is the library to store your wiki in a git repository.
#
module GitWiki
  class << self
    attr_accessor :repository_url
    def repository_url
      @repository_url || Dir.pwd
    end
  end
end

require 'git_wiki/repository'
require 'git_wiki/git_resource'
require 'git_wiki/page'

