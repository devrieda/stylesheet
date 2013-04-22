module Stylesheet
  class CssImportRule < CssRule

    attr_reader :media

    def type
      CssRule::IMPORT_RULE
    end

    def href
      @href
    end

    def style_sheet
      @style_sheet ||= CssStyleSheet.new(location.href)
    end

    def self.matches_rule?(text)
      text.include?("@import")
    end

    def location
      @location ||= Location.new(@href,
        parent_style_sheet && parent_style_sheet.location)
    end

    private

    def href=(url)
      @href = url.gsub(/url\(|\)|['";]+/, "")
    end

    def media=(media)
      @media = MediaList.new(media)
    end
    
    def parse_css_text
      selector, self.href, self.media = css_text.gsub(";", "").split(" ", 3)
    end
  end
end