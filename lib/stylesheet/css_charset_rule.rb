module Stylesheet
  class CssCharsetRule < CssRule
    
    attr_reader :encoding

    def type
      CssRule::CHARSET_RULE
    end
    
    def self.matches_rule?(text)
      text.include?("@charset")
    end

    private
    
    def encoding=(encoding)
      @encoding = encoding.gsub(/["']+/, "")
    end

    def parse_css_text
      selector, self.encoding = css_text.gsub(";", "").split(" ", 2)
    end
  end
end