module Stylesheet
  class StyleSheetList
    extend Forwardable
    def_delegators :@styles, :length, :size, :[], :each, :to_s
    include Enumerable
    
    def initialize(styles)
      @styles = styles.map {|args| CssStyleSheet.new(args) }
    end

    def item(index)
      @styles[index]
    end
  end
end