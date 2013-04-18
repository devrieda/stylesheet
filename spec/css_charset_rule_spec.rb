require 'spec_helper'

describe CssCharsetRule do

  let(:css_text) { "@charset \"UTF-8\";" }

  let(:rule) do 
    CssCharsetRule.new(:css_text => css_text)
  end

  describe "#type" do 
    it "shows the type of style rule" do 
      expect(rule.type).to eq CssRule::CHARSET_RULE
    end
  end
  
  describe ".matches_rule?" do 
    it "should match text starting with @charset" do 
      matches = CssCharsetRule.matches_rule?(css_text)
      expect(matches).to be_true
    end
    
    it "should not match text without at-rule" do 
      matches = CssCharsetRule.matches_rule?("a:link { color: #357ad1; }")
      expect(matches).to be_false
    end

    it "should not match text without charset" do 
      matches = CssCharsetRule.matches_rule?("@import url(\"import1.css\");")
      expect(matches).to be_false
    end    
  end
end