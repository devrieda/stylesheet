module Stylesheet
  class CssStyleDeclaration
    extend Forwardable
    def_delegators :@declarations_list, :length, :size, :[], :each, :<<, :push, :delete, :to_s
    include Enumerable

    attr_reader :declarations, :parent_rule

    def initialize(options={})
      @declarations = Hash.new("")
      @parent_rule  = options[:parent_rule]
      self.css_text = options[:css_text]
    end

    def css_text=(css_text)
      @declarations_list = []

      re = /((?:'(?:\\'|.)*?'|"(?:\\"|.)*?"|\([^\)]*?\)|[^};])+)\s*/
      css_text.to_s.strip.chomp(";").scan(re).flatten.each do |declaration|
        next unless declaration.include?(":")

        property, value = declaration.split(":", 2)
        @declarations_list << declaration.strip
        @declarations[property.strip] = parse_value(value.strip)
      end
    end

    def css_text      
      css_text = @declarations_list.join("; ")
      css_text += ";" if css_text != ""
    end

    alias_method :to_s, :css_text

    def method_missing(name, *args)
      @declarations[Inflector.dasherize(name.to_s)]
    end

    private

    def parse_value(value)
      value
    end
  end
end
