module Stylesheet
  class CssCharsetRule < CssRule
    
    def type
      CssRule::CHARSET_RULE
    end
    
    def encoding
      ""
    end

    def self.matches_rule?(text)
      text.include?("@charset")
    end
    
    private
    
    def parse_css_text
      
    end
  end
end