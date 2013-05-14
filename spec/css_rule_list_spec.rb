require 'spec_helper'

describe CssRuleList do 
  
  let(:styles) do 
    "@charset \"UTF-8\";

    body {
      color: #444;
      background-color: #535353;
    }

    @import url(\"import1.css\");

    @media only screen and (max-width: 850px) {
      #main .section {
        font-weight: bold;
      }
    }
    
    @font-face {
      font-family: \"Bitstream Vera Serif Bold\";
      src: url(\"http://example.com/fonts/VeraSeBd.ttf\");
    }"
  end

  let(:style_w_comments) do     
    "body {
      color: #444;
      background-color: #535353;
    }

    /* style paragraphs */
    p {
      font-size: 90%;
    }"
  end
  
  let(:style_w_mismatched_comments) do 
    "body {
      color: #444;
      background-color: #535353;
    }

    */
    p {
      font-size: 90%;
    }"  end
  
  let(:style_w_empty_rules) do 
    "#cboxOverlay{color:#ccc}#colorbox{}#cboxTopLeft{width:21px;}"
  end

  describe ".new" do 
    it "parses charset rules" do 
      rules = CssRuleList.new(styles)
      expect(rules[0]).to be_kind_of(CssCharsetRule)
    end

    it "parses style rules" do 
      rules = CssRuleList.new(styles)
      expect(rules[1]).to be_kind_of(CssStyleRule)
    end

    it "parses import rules" do 
      rules = CssRuleList.new(styles)
      expect(rules[2]).to be_kind_of(CssImportRule)
    end

    it "parses media rules" do 
      rules = CssRuleList.new(styles)
      expect(rules[3]).to be_kind_of(CssMediaRule)
    end
    
    it "parses font face rules" do 
      rules = CssRuleList.new(styles)
      expect(rules[4]).to be_kind_of(CssFontFaceRule)
    end

    it "removes comments" do 
      rules = CssRuleList.new(style_w_comments)
      expect(rules.length).to eq 2
      expect(rules[0].css_text).to eq "body { color: #444;background-color: #535353;}"
      expect(rules[1].css_text).to eq "p { font-size: 90%;}"
    end
    
    it "removes mismatched comments" do 
      rules = CssRuleList.new(style_w_mismatched_comments)
      expect(rules.length).to eq 2
      expect(rules[0].css_text).to eq "body { color: #444;background-color: #535353;}"
      expect(rules[1].css_text).to eq "p { font-size: 90%;}"
    end
    
    it "parses empty rules" do 
      rules = CssRuleList.new(style_w_empty_rules)
      expect(rules.length).to eq 3
      expect(rules[0].css_text).to eq "#cboxOverlay{color:#ccc}"
      expect(rules[1].css_text).to eq "#colorbox{}"
      expect(rules[2].css_text).to eq "#cboxTopLeft{width:21px;}"
    end
  end
  
  describe "#[]" do 
    it "finds a css style sheet at the given index" do 
      rules = CssRuleList.new(styles)
      expect(rules[0]).to be_kind_of(CssRule)
    end
  end

  describe "#length" do 
    it "returns number of items" do 
      rules = CssRuleList.new(styles)
      expect(rules.length).to eq 5
    end
  end
  
  describe "#item" do 
    it "finds a css style sheet at the given index" do 
      rules = CssRuleList.new(styles)
      expect(rules.item(0)).to be_kind_of(CssRule)
    end
  end
end