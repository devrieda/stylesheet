module Stylesheet
  class CssRuleList
    extend Forwardable
    def_delegators :@rules, :length, :[], :each
    include Enumerable

    def initialize(rules)
      @rules = parse(rules)
    end

    def item(index)
      @rules[index]
    end
    
    private
    
    def parse(rules)
      # clean extraneous whitespace
      rules = rules.to_s.gsub("\n", "").gsub(/\s+/, " ").gsub(/([\};])\s/, '\1')

      directive_re = "@.+?;"
      rules_re     = ".+?\{.+?\}"
      split_rules = rules.scan(/(#{directive_re}|#{rules_re})/im).map {|r| r[0] }

      split_rules.map {|css_text| CssRule.factory(:css_text => css_text) }
    end
  end
end