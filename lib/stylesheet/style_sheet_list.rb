module Stylesheet
  class StyleSheetList < Array
    def initialize(styles)
      @styles = styles.map {|args| CssStyleSheet.new(args) }
      super @styles
    end

    def item(index)
      self[index]
    end
  end
end