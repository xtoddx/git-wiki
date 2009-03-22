require File.join(File.dirname(__FILE__), 'helper')

describe 'A Missing Page' do
  include Sinatra::Test

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
