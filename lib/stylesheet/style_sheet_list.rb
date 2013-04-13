module Stylesheet
  class StyleSheetList
    extend Forwardable
    def_delegators :@styles, :length, :[], :each
    include Enumerable
    
    def initialize(styles)
      @styles = styles.map {|args| CssStyleSheet.new(args) }
    end

    def item(index)
      @styles[index]
    end
  end
end