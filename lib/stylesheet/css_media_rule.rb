module Stylesheet
  class CssMediaRule < CssRule
    
    attr_reader :content

    def initialize(args)
      super
    end
    
    def type
      CssRule::MEDIA_RULE
    end

    def css_rules
      @css_rules ||= CssRuleList.new(content)
    end

    def self.matches_rule?(text)
      text.include?("@media")
    end
    
    private
    
    def parse_css_text
      return unless css_text.include?("{")

      @content = if matches = css_text.match(/\{(.*)\}/mi)
        matches[1]
      else
        ""
      end
    end
  end
end