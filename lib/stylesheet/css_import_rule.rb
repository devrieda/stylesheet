module Stylesheet
  class CssImportRule < CssRule

    def initialize(args)
      super
    end
    
    def type
      CssRule::IMPORT_RULE
    end
    
    def href
      ""
    end
    
    def style_sheet
      
    end

    def self.matches_rule?(text)
      text.include?("@import")
    end

    private

    def parse_css_text
      
    end
  end
end