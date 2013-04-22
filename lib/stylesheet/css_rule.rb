module Stylesheet
  class CssRule
    STYLE_RULE     = 1
    CHARSET_RULE   = 2
    IMPORT_RULE    = 3
    MEDIA_RULE     = 4
    FONT_FACE_RULE = 5

    attr_writer :type
    attr_reader :parent_style_sheet, :parent_rule, :css_text


    # keep track of subclasses for factory
    class << self
      attr_reader :rule_classes
    end

    @rule_classes = []

    def self.inherited(subclass)
      CssRule.rule_classes << subclass
    end

    def self.factory(args)
      rule = CssRule.rule_classes.find do |klass| 
        klass.matches_rule?(args[:css_text])
      end
      rule.new(args) if rule
    end


    def initialize(args)
      @parent_style_sheet = args[:parent_style_sheet]
      @parent_rule        = args[:parent_rule]
      @css_text           = args[:css_text]
      parse_css_text
    end

    def type
      raise NotImplementedError
    end

    def matches_rule?
      false
    end

    private

    def parse_css_text(css_text)
      raise NotImplementedError
    end
  end
end