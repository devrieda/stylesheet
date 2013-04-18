require 'spec_helper'

describe CssRuleList do 
  
  let(:styles) do 
    "@charset \"UTF-8\";

    body {
      color: #444;
      background-color: #535353;
    }

    @import url(\"import1.css\");

    a:link { 
      color: #357ad1; 
    }
    a:visited { 
      color: #77abf0; 
    }

    @media only screen and (max-width: 850px) {
      #main .section {
        font-weight: bold;
      }
    }
    
    @font-face {
      font-family: \"Bitstream Vera Serif Bold\";
      src: url(\"http://example.com/fonts/VeraSeBd.ttf\");
    }

    a:hover {
      color: #333;
    }"
  end
  
  describe ".new" do 
    it "parses charset rules" do 
      rules = CssRuleList.new(styles)
      expect(rules[0]).to be_kind_of(CssCharsetRule)
    end
    
    it "parses import rules" do 
      rules = CssRuleList.new(styles)
      expect(rules[2]).to be_kind_of(CssImportRule)
    end
    
    it "parses font face rules" do 
      rules = CssRuleList.new(styles)
      expect(rules[6]).to be_kind_of(CssFontFaceRule)
    end
    
    it "parses media rules" do 
      rules = CssRuleList.new(styles)
      expect(rules[5]).to be_kind_of(CssMediaRule)
    end
    
    it "parses style rules" do 
      rules = CssRuleList.new(styles)
      expect(rules[1]).to be_kind_of(CssStyleRule)
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
      expect(rules.length).to eq 8
    end
  end
  
  describe "#item" do 
    it "finds a css style sheet at the given index" do 
      rules = CssRuleList.new(styles)
      expect(rules.item(0)).to be_kind_of(CssRule)
    end
  end
end