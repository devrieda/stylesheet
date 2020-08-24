require 'spec_helper'

describe CssStyleRule do 
  
  let(:css_text) do 
    "#main .body a:link { font-weight: bold; text-decoration: none; }"
  end

  let(:rule) do 
    CssStyleRule.new(:css_text => css_text)
  end

  describe "#selector_text" do 
    it "returns only selector text for the style rule" do 
      expect(rule.selector_text).to eq "#main .body a:link"
    end
  end

  describe "#style" do 
    it "returns the css style declaration for the rule" do 
      style = rule.style

      expect(style).to be_kind_of(CssStyleDeclaration)
      expect(style.length).to eq 2
    end
    
    it "returns the css style declaration for rules with missing end semicolon" do 
      css_text = "#main .body a:link { font-weight: bold; text-decoration: none }"
      rule = CssStyleRule.new(:css_text => css_text)

      expect(rule.style).to be_kind_of(CssStyleDeclaration)
      expect(rule.style.length).to eq 2
    end
  end
  
  describe "#type" do 
    it "shows the type of style rule" do 
      expect(rule.type).to eq CssRule::STYLE_RULE
    end
  end
  
  describe ".matches_rule?" do 
    it "should match text that doesn't begin with an at-rule" do 
      matches = CssStyleRule.matches_rule?(css_text)
      expect(matches).to eq true
    end
    
    it "should not match rules starting with at-rule" do 
      matches = CssStyleRule.matches_rule?("@import url(\"import1.css\");")
      expect(matches).to eq false
    end
  end
end
