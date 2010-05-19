require File.join(File.dirname(__FILE__), '..', 'webapp_helper')
require File.join(File.dirname(__FILE__), '..', 'test_brancher')

describe 'The homepage' do
  include TestBrancher
  include WebappHelper
  include Rack::Test::Methods

  it 'should be shown from slash' do
    get '/'
    assert_equal 200, last_response.status
  end

  it 'should redirect to slash from Homepage' do
    get '/Homepage'
    assert_equal '/', last_response.headers['Location']
  end
end
