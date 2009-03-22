require File.join(File.dirname(__FILE__), '..', 'gitwiki_helper')
require File.join(File.dirname(__FILE__), '..', 'test_brancher')

context 'The GitResource class' do
  include TestBrancher

  setup do
    GitWiki.repository_url = 'test/test_wiki'
    GitWiki.repository_branch = 'test_in_progress'
  end

  it 'should raise MissingResource when it cant find an object' do
    assert_raise GitWiki::GitResource::MissingResource do
      GitWiki::GitResource.find('new-page')
    end
  end

  it 'should return a list of all entries' do
    assert_kind_of Array, GitWiki::GitResource.find_all
  end

  it 'should find by name' do
    assert_kind_of GitWiki::GitResource, GitWiki::GitResource.find('01-a-page')
  end

  it 'should return a default if not found' do
    assert_kind_of GitWiki::GitResource, GitWiki::GitResource.find_or_create('new-page')
  end

  it 'should return actual item (not default) if found' do
    assert_kind_of GitWiki::GitResource, GitWiki::GitResource.find_or_create('01-a-page')
  end

  it 'should let us know if the named resource exists' do
    assert GitWiki::GitResource.exists?('01-a-page')
  end

  it 'should not tell us a missing resource exists' do
    assert !(GitWiki::GitResource.exists?('new-page'))
  end

  it 'should find a missing page without raising an error (return nil)' do
    assert_nil GitWiki::GitResource.find_gracefully('new-page')
  end

  it 'should find an existing page gracefully' do
    assert_kind_of GitWiki::GitResource, GitWiki::GitResource.find_gracefully('01-a-page')
  end

  it 'should create pages with a sane name' do
    r = GitWiki::GitResource.find_or_create('newpage')
    r.content = "NEW CONTENT"
    r.save
    assert GitWiki::GitResource.find('newpage')
  end
end
