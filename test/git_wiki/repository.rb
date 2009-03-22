require File.join(File.dirname(__FILE__), 'helper')

context 'A Repository' do
  it 'should provide an instance initialized to GitWiki.repository_url' do
    GitWiki.repository_url = 'test/test_wiki'
    assert GitWiki::Repository.instance
  end
end
