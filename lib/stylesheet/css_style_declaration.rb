module Stylesheet
  class CssStyleDeclaration
    extend Forwardable
    def_delegators :@declarations, :length, :[], :each, :<<, :push, :delete
    include Enumerable

    attr_reader :parent_rule

    def initialize(options={})
      @parent_rule  = options[:parent_rule]
      self.css_text = options[:css_text]
    end

    def css_text=(css_text)
      @declarations = css_text.to_s.split(";").map {|d| d.strip }
    end

    def css_text
      css_text = @declarations.join("; ")
      css_text += ";" if css_text != ""
    end

    alias_method :to_s, :css_text
    
    def method_missing
      
    end
  end
end