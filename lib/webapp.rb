$: << 'lib'
require 'rubygems'
require 'sinatra'
require 'git_wiki'

class Webapp < Sinatra::Base

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
      page_not_found(name)
    end
  end

  def page_not_found name
    if request.accept.empty? or request.accept.include?('text/html')
      redirect "/#{name}/edit"
      halt
    else
      halt 404, 'not found'
    end
  end

  def lookup_layout engine, options
    layout = GitWiki::Layout.find_gracefully("layout.#{engine}")
    if layout
      return layout.name, layout.content
    else
      return nil, nil
    end
  end

  def lookup_template engine, template, options={}
    if template.is_a?(Symbol) and cached=self.class.templates[template]
      super(engine, cached, options)
    elsif template.is_a?(Symbol)
      if rv = GitWiki::View.find_gracefully("#{template}.#{engine}")
        rv.content
      else
        super(engine, template, options)
      end
    else
      super(engine, template, options)
    end
  end
end
