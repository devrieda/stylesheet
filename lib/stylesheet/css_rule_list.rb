module Stylesheet
  class CssRuleList
    extend Forwardable
    def_delegators :@rules, :length, :[], :each
    include Enumerable

    def initialize(rules)
      @rules = []
    end

    def item(index)
      @rules[index]
    end
  end
end