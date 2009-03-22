module GitWiki
  ##
  # Every GitResource should respond to a few basic methods to let
  # the repository interface cleanly with it.
  # * initialize(blob)
  # * blob [ probalby just an attr_reader on the initilized object ]
  # * content [ the current content ]
  #
  class GitResource

    class MissingResource < StandardError ; end

    attr_accessor :content
    attr_reader :blob

    ##
    # Create the object and set the blob and content
    #
    def initialize blob
      @blob = blob
      self.content = blob.data
    end

    ##
    # store this object in the git repo
    # short circuit if there isn't a change to the underlying content
    #
    def save
      return if @blob.data == content
      repository.store(self, commit_message)
    end

    ##
    # remove this object from the git repo
    #
    def delete
      repository.purge(self, "Deleted #{self.class.name} #{name}")
    end

    ##
    # return just the class and name
    #
    def to_s
      "#{self.class.name} #{name}"
    end

    ##
    # Is this not stored in git yet?
    #
    def new?
      blob.id.nil?
    end

    ##
    # Name of this object (from git blob)
    #
    def name
      blob.name
    end

    private
    def repository
      self.class.send(:repository)
    end

    def commit_message
      new? ? \
        "Created #{self.class.name} #{name}" : \
        "Updated #{self.class.name} #{name}"
    end

    module ClassMethods
      ##
      # Find every entry in the repository and pass it to the initializer
      #
      def find_all
        return [] if repository.tree.contents.empty?
        repository.tree.contents.collect { |blob| new(blob) }
      end

      ##
      # Very quickly let us know if a resource exists
      #
      def exists? name
        find_blob(name)
      end

      ##
      # Given a name, find the resource
      #
      def find(name)
        page_blob = find_blob(name)
        raise MissingResource unless page_blob
        new(page_blob)
      end

      ##
      # Find by name, or return a default
      #
      def find_or_create(name)
        if page_blob = find_blob(name)
          new(page_blob)
        else
          new(create_blob_for(name))
        end
      end

      ##
      # Find without raising an error
      #
      def find_gracefully name
        if blob = find_blob(name)
          new(blob)
        else
          nil
        end
      end

      private
      def repository
        @repo ||= GitWiki::Repository.instance
      end

      def find_blob(name)
        repository.tree/name
      end

      def create_blob_for(name)
        Grit::Blob.create(repository, {
          :name => name,
          :data => ""
        })
      end
    end

    extend ClassMethods

  end
end
