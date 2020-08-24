module Stylesheet
  class Document

    def initialize(url=nil)
      @url = url
    end

    def location
      @location ||= Location.new(@url)
    end
    
    def location=(location)
      @location = location
    end

    def text 
      @text ||= request_content
    end

    def style_sheets
      @style_sheets ||= StyleSheetList.new(styles)
    end

    def to_s
      "#<Document location:#{location.href}>"
    end

    private

    def styles
      (inline_styles + external_styles).map do |style|
        html = style.inner_html
        { parent:  self,
          content: html != "" ? html : nil,
          href:    style["href"],
          media:   style["media"],
          title:   style["title"] }
      end
    end

    # find all inline styles and build new stylesheet from them
    def inline_styles
      parser.css("style").to_a
    end

    def external_styles
      parser.css("link[rel='stylesheet']").to_a
    end
    
    def request_content
      raise InvalidLocationError unless location.valid?

      request.get(location.href)
    end

    def parser
      @parser ||= Nokogiri::HTML(text)
    end

    def request
      @request ||= Stylesheet.request
    end
  end
end
