require File.join(File.dirname(__FILE__), '..', 'webapp_helper')
require File.join(File.dirname(__FILE__), '..', 'test_brancher')

describe 'A Missing Page' do
  include Sinatra::Test
  include TestBrancher
  include WebappHelper

  it 'should redirect to edit' do
    get '/missing'
    assert_equal '/missing/edit', @response.headers['Location']
  end

  it 'should be editable' do
    get '/missing/edit'
    assert_equal 200, @response.status
  end

  it 'should be creatable' do
    post '/missing', {:body => 'This is a cool new body'}
    assert_match 'This is a cool new body', @response.body

    pg = GitWiki::Page.find('missing')
    pg.delete
  end

end
