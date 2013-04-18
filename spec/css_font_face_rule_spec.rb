require 'spec_helper'

describe CssFontFaceRule do

  let(:css_text) do 
    "@font-face {
      font-family: \"Bitstream Vera Serif Bold\";
      src: url(\"http://example.com/fonts/VeraSeBd.ttf\");
    }" 
  end

  let(:rule) do 
    CssFontFaceRule.new(:css_text => css_text)
  end

  describe "#style" do 
    it "returns the css style declaration for the rule" do 
      expect(rule.style).to be_kind_of(CssStyleDeclaration)
    end
  end

  describe "#type" do 
    it "shows the type of style rule" do 
      expect(rule.type).to eq CssRule::FONT_FACE_RULE
    end
  end
  
  describe ".matches_rule?" do 
    it "should match text starting with @font-face" do 
      matches = CssFontFaceRule.matches_rule?(css_text)
      expect(matches).to be_true
    end
    
    it "should not match text without at-rule" do 
      matches = CssFontFaceRule.matches_rule?("a:link { color: #357ad1; }")
      expect(matches).to be_false
    end

    it "should not match text without font-face" do 
      matches = CssFontFaceRule.matches_rule?("@import url(\"import1.css\");")
      expect(matches).to be_false
    end
  end
end