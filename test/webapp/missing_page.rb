require File.join(File.dirname(__FILE__), '..', 'webapp_helper')
require File.join(File.dirname(__FILE__), '..', 'test_brancher')

describe 'A Missing Page' do
  include TestBrancher
  include WebappHelper
  include Rack::Test::Methods

  it 'should redirect to edit' do
    get '/missing'
    assert_equal '/missing/edit', last_response.headers['Location']
  end

  it 'should be editable' do
    get '/pages/missing'
    assert_equal 200, last_response.status
  end

  it 'should be creatable' do
    post '/pages/missing', {:body => 'This is a cool new body'}
    assert_match 'This is a cool new body', last_response.body
    pg = GitWiki::Page.find('missing')
    pg.delete
  end

end
