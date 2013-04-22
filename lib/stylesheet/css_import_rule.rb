module Stylesheet
  class CssImportRule < CssRule
    
    attr_reader :media
    
    def initialize(args)
      super
    end
    
    def type
      CssRule::IMPORT_RULE
    end

    def href
      @location.href
    end

    def style_sheet
      @style_sheet ||= CssStyleSheet.new(location.href)
    end

    def self.matches_rule?(text)
      text.include?("@import")
    end

    private

    def href=(url)
      @url  = url
      @href = location.to_s
    end

    def media=(media)
      @media ||= MediaList.new(media)
    end
    
    def location
      @location ||= Location.new(@url.gsub(/url\(|\)|['";]+/, ""), 
        parent_style_sheet && parent_style_sheet.location)
    end

    def parse_css_text
      selector, url, media = css_text.split(" ", 3)

      self.href  = url
      self.media = media
    end
    
    def request
      @request ||= Stylesheet.request
    end
  end
end