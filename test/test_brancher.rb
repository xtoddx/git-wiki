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
    `cd test/test_wiki && git checkout -b test_in_progress f3c843841ed85d65eb4d16acf61b3e5e4b1dfdf7 > /dev/null 2>&1`
  end

  def self.unbranch
    `cd test/test_wiki && git checkout f3c843841ed85d65eb4d16acf61b3e5e4b1dfdf7 > /dev/null 2>&1 && git branch -D test_in_progress > /dev/null 2>&1`
  end
end
