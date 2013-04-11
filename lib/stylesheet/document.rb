module Stylesheet
  class Document
    attr_accessor :url
    
    def initialize(url)
      @url = url
    end

    def location
      @location ||= Location.new(url)
    end

    def text 
      @text ||= request_content
    end

    def style_sheets
      @style_sheets ||= StyleSheetList.new(styles)
    end


    private

    def styles 
      (inline_styles + external_styles).each do |style|
         { parent:  self,
           content: style.inner_html, 
           href:    style["href"],
           media:   style["media"],
           title:   style["title"] }
      end
    end

    # find all inline styles and build new stylesheet from them
    def inline_styles
      parser.css("style").map {|style| style }
    end

    def external_styles
      parser.css("link[rel='stylesheet']").map {|style| style }
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