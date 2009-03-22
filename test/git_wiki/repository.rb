require File.join(File.dirname(__FILE__), '..', 'gitwiki_helper')
require File.join(File.dirname(__FILE__), '..', 'test_brancher')

context 'A Repository' do
  include TestBrancher

  it 'should provide an instance initialized to GitWiki.repository_url' do
    GitWiki.repository_url = 'test/test_wiki'
    assert GitWiki::Repository.instance
  end
end
