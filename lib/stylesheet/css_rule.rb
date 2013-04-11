module Stylesheet
  class CssRule
    STYLE_RULE     = 1
    CHARSET_RULE   = 2
    IMPORT_RULE    = 3
    MEDIA_RULE     = 4
    FONT_FACE_RULE = 5

    attr_accessor :css_text, :parent_rule, :parent_style_sheet, :type

    def initialize(args)
      @css_text           = args[:css_text]
      @parent_rule        = args[:parent_rule]
      @parent_style_sheet = args[:parent_style_sheet]
      @type               = args[:type]
    end
  end
end