module Stylesheet
  class CssNullRule < CssRule

    def type
      CssRule::NULL_RULE
    end

    def self.matches_rule?(text)
      true
    end

    private

    def parse_css_text; end
  end
end