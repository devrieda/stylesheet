require 'spec_helper'

describe CssImportRule do
  let(:css_text) { "@import url(\"import1.css\");" }

  let(:rule) do 
    CssImportRule.new(:css_text => css_text)
  end

  describe "#type" do 
    it "shows the type of style rule" do 
      expect(rule.type).to eq CssRule::IMPORT_RULE
    end
  end
  
  describe ".matches_rule?" do 
    it "should match text starting with @import" do 
      matches = CssImportRule.matches_rule?(css_text)
      expect(matches).to be_true
    end
    
    it "should not match text without at-rule" do 
      matches = CssImportRule.matches_rule?("a:link { color: #357ad1; }")
      expect(matches).to be_false
    end

    it "should not match text without import" do 
      matches = CssImportRule.matches_rule?("@charset \"UTF-8\";")
      expect(matches).to be_false
    end
  end
end