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
  
  describe "#encoding" do 
    it "should return specified encoding" do 
      expect(rule.encoding).to eq "UTF-8"
    end
  end

  describe ".matches_rule?" do 
    it "should match text starting with @charset" do 
      matches = CssCharsetRule.matches_rule?(css_text)
      expect(matches).to eq true
    end
    
    it "should not match text without at-rule" do 
      matches = CssCharsetRule.matches_rule?("a:link { color: #357ad1; }")
      expect(matches).to eq false
    end

    it "should not match text without charset" do 
      matches = CssCharsetRule.matches_rule?("@import url(\"import1.css\");")
      expect(matches).to eq false
    end    
  end
end
