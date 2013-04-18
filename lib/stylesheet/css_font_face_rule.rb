module Stylesheet
  class CssFontFaceRule < CssRule

    def initialize(args)
      super
    end
    
    def type
      CssRule::FONT_FACE_RULE
    end

    def style
      CssStyleDeclaration.new
    end

    def self.matches_rule?(text)
      text.include?("@font-face")
    end

    private
    
    def parse_css_text
      
    end
  end
end