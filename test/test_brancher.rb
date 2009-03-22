module TestBrancher
  def self.included kls
    kls.send :setup do
      TestBrancher.branch
    end

    kls.send :teardown do
      TestBrancher.unbranch
    end
  end

  def self.branch
    `cd test/test_wiki && git checkout -b test_in_progress 46d0cfa04c973d23e4dd3da2b4a7fa3e245dd9fd > /dev/null 2>&1`
  end

  def self.unbranch
    `cd test/test_wiki && git checkout 46d0cfa04c973d23e4dd3da2b4a7fa3e245dd9fd > /dev/null 2>&1 && git branch -D test_in_progress > /dev/null 2>&1`
  end
end
