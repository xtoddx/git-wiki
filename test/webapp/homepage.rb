require File.join(File.dirname(__FILE__), 'helper')

describe 'The homepage' do
  include Sinatra::Test

  it 'should be shown from slash' do
    get '/'
    assert_equal 200, @response.status
  end

  it 'should redirect to slash from Homepage' do
    get '/Homepage'
    assert_equal '/', @response.headers['Location']
  end
end
