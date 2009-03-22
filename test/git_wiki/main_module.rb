require File.join(File.dirname(__FILE__), '..', 'gitwiki_helper')

describe 'The main GitWiki module' do
  it 'should provide a default repository_url' do
    assert GitWiki.repository_url
  end

  it 'should allow setting a reposity_url' do
    GitWiki.repository_url = 'foobar'
    assert_equal 'foobar', GitWiki.repository_url
  end

  it 'should provide a default repository_branch' do
    assert GitWiki.repository_branch
  end

  it 'should allow setting a reposity_branch' do
    GitWiki.repository_branch = 'foobar'
    assert_equal 'foobar', GitWiki.repository_branch
  end
end
