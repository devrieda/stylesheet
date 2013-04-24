module Stylesheet
  class CssStyleRule < CssRule

    attr_reader :selector_text

    def type
      CssRule::STYLE_RULE
    end
    
    def style
      CssStyleDeclaration.new(:css_text    => @declarations, 
                              :parent_rule => self)
    end

    def self.matches_rule?(text)
      !text.include?("@")
    end

    private

    def parse_css_text
      return unless css_text.include?("{")

      selector, declarations = css_text.split("{")
      @selector_text = selector.strip
      @declarations  = declarations.gsub(/\}\s*$/, "")
    end
  end
end