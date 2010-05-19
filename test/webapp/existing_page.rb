require File.join(File.dirname(__FILE__), '..', 'webapp_helper')
require File.join(File.dirname(__FILE__), '..', 'test_brancher')

describe 'An Existing Page' do
  include TestBrancher
  include WebappHelper
  include Rack::Test::Methods

  it 'should be viewable' do
    get '/01-a-page'
    assert_equal 200, last_response.status
  end

  it 'should be editable' do
    get '/pages/01-a-page'
    assert_equal 200, last_response.status
  end

  it 'should process an edit' do
    post '/pages/01-a-page', :body => 'New Page'
    assert_match 'New Page', last_response.body
  end

end
