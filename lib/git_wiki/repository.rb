require 'singleton'

begin
  require 'grit'
rescue LoadError => e
  require 'rubygems'
  require 'grit'
end

module GitWiki
  class Repository < Grit::Repo
    include Singleton

    def initialize
      super(GitWiki.repository_url)
    end

    def tree
      super(GitWiki.repository_branch)
    end

    ##
    # Save the (possibly new) GitResource in the git repo.
    # Use the given commit message.
    #
    def store obj, msg
      Dir.chdir(working_dir) do
        File.open(obj.blob.name, 'w'){ |f| f.write(obj.content) }
        add(obj.blob.name)
      end
      commit_index(msg)
    end

    ##
    # Remove the given GitResource from the git repo.
    # Use the given commit message.
    #
    def purge obj, msg
      Dir.chdir(working_dir) do
        if File.file?(obj.blob.name)
          FileUtils.rm(obj.blob.name)
        end
        remove(obj.blob.name)
      end
      commit_index(msg)
    end
  end
end
