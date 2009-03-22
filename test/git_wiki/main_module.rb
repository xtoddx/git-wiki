require File.join(File.dirname(__FILE__), 'helper')

context 'The main GitWiki module' do
  it 'should provide a default repository_url' do
    assert GitWiki.repository_url
  end

  it 'should allow setting a reposity_url' do
    GitWiki.repository_url = 'foobar'
    assert_equal 'foobar', GitWiki.repository_url
  end

end
