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
      @declarations, @rules = [], Hash.new("")

      css_text.to_s.strip.chomp(";").split(";").each do |declaration|
        property, value = declaration.split(":", 2)
        @declarations << declaration.strip
        @rules[Inflector.camelize(property.strip)] = parse_value(value.strip)
      end
    end

    def css_text      
      css_text = @declarations.join("; ")
      css_text += ";" if css_text != ""
    end

    alias_method :to_s, :css_text

    def method_missing(name, *args)
      @rules[name.to_s]
    end

    private

    def parse_value(value)
      value
    end
  end
end
