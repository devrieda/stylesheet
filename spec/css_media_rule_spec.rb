require 'spec_helper'

describe CssMediaRule do

  let(:css_text) do
    "@media only screen and (max-width: 850px) {
      #main .section {
        font-weight: bold;
      }
      #main a:link {
        text-decoration: none;
      }
    }"
  end

  let(:rule) do 
    CssMediaRule.new(:css_text => css_text)
  end

  describe "#css_rules" do 
    it "should find child rules" do 
      expect(rule.css_rules).to be_kind_of CssRuleList
      expect(rule.css_rules.length).to eq 2
    end
    
    it "should find child rules when none are present" do 
      css_text = "@media only screen and (max-width: 850px) {}"
      rule     = CssMediaRule.new(:css_text => css_text)

      expect(rule.css_rules).to be_kind_of CssRuleList
      expect(rule.css_rules.length).to eq 0
    end
  end

  describe "#type" do 
    it "shows the type of style rule" do 
      expect(rule.type).to eq CssRule::MEDIA_RULE
    end
  end
  
  describe ".matches_rule?" do 
    it "should match text starting with @media" do 
      matches = CssMediaRule.matches_rule?(css_text)
      expect(matches).to eq true
    end

    it "should not match text without at-rule" do 
      matches = CssMediaRule.matches_rule?("a:link { color: #357ad1; }")
      expect(matches).to eq false
    end

    it "should not match text without media" do 
      matches = CssMediaRule.matches_rule?("@charset \"UTF-8\";")
      expect(matches).to eq false
    end
  end
end
