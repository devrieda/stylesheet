module Stylesheet
  class CssRuleList
    extend Forwardable
    def_delegators :@rules, :length, :[], :each
    include Enumerable

    def initialize(rules, parent = nil)
      @rules = parse(rules, parent)
    end

    def item(index)
      @rules[index]
    end
    
    private
    
    def parse(rules, parent)
      # clean extraneous whitespace
      rules = rules.to_s.gsub("\n", "").gsub(/\s+/, " ").gsub(/([\};])\s/, '\1')

      directive_re = "@.+?;"
      rules_re     = ".+?\{.+?\}"
      split_rules = rules.scan(/(#{directive_re}|#{rules_re})/im).map {|r| r[0] }

      split_rules.map do |css_text| 
        CssRule.factory(:css_text => css_text, :parent_style_sheet => parent)
      end
    end
  end
end