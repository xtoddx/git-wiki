module GitWiki
  ##
  # Every GitResource should respond to a few basic methods to let
  # the repository interface cleanly with it.
  # * initialize(blob, path)
  # * blob [ probalby just an attr_reader on the initilized object ]
  # * content [ the current content ]
  #
  class GitResource

    class MissingResource < StandardError ; end

    attr_accessor :content, :path
    attr_reader :blob

    ##
    # Create the object and set the blob and content
    #
    def initialize blob, path
      @blob = blob
      self.content = blob.data
      self.path = path
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
      def find_all root=nil, path=''
        if root.nil?
          root = repository.tree
          if @git_path
            root = root/@git_path
          end
        end
        r_find(root, path)
      end

      ##
      # Very quickly let us know if a resource exists
      #
      def exists? path
        find_blob(full_path(path))
      end

      ##
      # Given a name, find the resource
      #
      def find(path)
        path = full_path(path)
        page_blob = find_blob(path)
        raise MissingResource unless page_blob
        new(page_blob, path)
      end

      ##
      # Find by name, or return a default
      #
      def find_or_create(path)
        path = full_path(path)
        if page_blob = find_blob(path)
          new(page_blob, path)
        else
          new(create_blob_for(path), path)
        end
      end

      ##
      # Find without raising an error
      #
      def find_gracefully path
        path = full_path(path)
        if blob = find_blob(path)
          new(blob, path)
        else
          nil
        end
      end

      private
      def repository
        @repo ||= GitWiki::Repository.instance
      end

      def find_blob(path)
        repository.tree/path
      end

      def create_blob_for(path)
        Grit::Blob.create(repository, {
          :name => path,
          :data => ""
        })
      end

      def r_find tree_or_blob, path
        if tree_or_blob.is_a?(Grit::Blob)
          [new(tree_or_blob, full_path(path))]
        else
          tree_or_blob.contents.inject([]){|m,x| m + r_find(x, File.join(path, x.name))}
        end
      end

      # so subclasses don't have to overwrite finders
      def set_git_path basedir
        @git_path = basedir
      end

      def full_path path
        @git_path ? File.join(@git_path, path) : path
      end
    end

    extend ClassMethods

  end
end
