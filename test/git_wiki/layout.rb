require File.join(File.dirname(__FILE__), '..', 'gitwiki_helper')
require File.join(File.dirname(__FILE__), '..', 'test_brancher')

context 'The Layout class' do
  include TestBrancher

  setup do
    GitWiki.repository_url = 'test/test_wiki'
    GitWiki.repository_branch = 'test_in_progress'
  end

  it 'should find by name' do
    assert_kind_of GitWiki::Layout, GitWiki::Layout.find('layout.haml')
  end

end
