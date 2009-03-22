begin
  require 'rdiscount'
rescue LoadError => e
  require 'rubygems'
  require 'rdiscount'
end
require 'fileutils'

module GitWiki
  class Page < GitResource

    def to_html
      RDiscount.new(wiki_link(content)).to_html
    end

    alias :url :name

    private

      ##
      # XXX: shouldn't this be done on save, not on update
      # XXX: might not be an issue if use use FCKEditor for links
      #
      def wiki_link(str)
        str.gsub(/([A-Z][a-z]+[A-Z][A-Za-z0-9]+)/) { |page|
          %Q{<a class="#{self.class.css_class_for(page)}"} +
            %Q{href="/#{page}">#{page}</a>}
        }
      end
  end
end
