require File.join(File.dirname(__FILE__), 'helper')

describe 'An Existing Page' do
  include Sinatra::Test

  it 'should be viewable' do
    get '/01-a-page'
    assert_equal 200, @response.status
  end

  it 'should be editable' do
    get '/01-a-page/edit'
    assert_equal 200, @response.status
  end

  it 'should process an edit' do
    post '/01-a-page', :body => 'New Page'
    assert_match 'New Page', @response.body
  end

end
