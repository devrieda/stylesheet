module Stylesheet
  class CssFontFaceRule < CssRule

    def type
      CssRule::FONT_FACE_RULE
    end

    def style
      CssStyleDeclaration.new(:css_text    => @declarations, 
                              :parent_rule => self)
    end

    def self.matches_rule?(text)
      text.include?("@font-face")
    end

    private
    
    def parse_css_text
      return unless css_text.include?("{")

      selector, declarations = css_text.split("{")
      @declarations = declarations.strip.gsub(/\}\s*$/, "")
    end
  end
end