$: << 'lib'
require 'rubygems'
require 'sinatra'
require 'git_wiki'

use_in_file_templates!

before do
  content_type "text/html", :charset => "utf-8"
end

get "/" do
  show_page('Homepage')
end

get "/Homepage" do
  redirect "/"
end

get "/pages" do
  @pages = GitWiki::Page.find_all
  haml :list
end

get "/:page/edit" do
  @page = GitWiki::Page.find_or_create(params[:page])
  haml :edit
end

get "/:page" do
  show_page(params[:page])
end

post "/:page" do
  @page = GitWiki::Page.find_or_create(params[:page])
  @page.content = params[:body]
  @page.save
  haml :show
end

private
  def title(title=nil)
    @title = title.to_s unless title.nil?
    @title
  end

  def list_item(page)
    %Q{<a class="page_name" href="/#{page.url}">#{page.name}</a>}
  end

  def show_page name
    if @page = GitWiki::Page.find_gracefully(name)
      haml :show
    else
      redirect "/#{name}/edit"
      halt
    end
  end

__END__
@@ layout
!!!
%html
  %head
    %title= title
  %body
    %ul
      %li
        %a{ :href => "/" } Home
      %li
        %a{ :href => "/pages" } All pages
    #content= yield

@@ show
- title @page.name
#edit
  %a{:href => "/#{@page}/edit"} Edit this page
%h1= title
#content
  ~"#{@page.to_html}"

@@ edit
- title "Editing #{@page.name}"
%h1= title
%form{:method => 'POST', :action => "/#{@page.url}"}
  %p
    %textarea{:name => 'body', :rows => 30, :style => "width: 100%"}= @page.content
  %p
    %input.submit{:type => :submit, :value => "Save as the newest version"}
    or
    %a.cancel{:href=>"/#{@page}"} cancel

@@ list
- title "Listing pages"
%h1 All pages
- if @pages.empty?
  %p No pages found.
- else
  %ul#list
    - @pages.each do |page|
      %li= list_item(page)
