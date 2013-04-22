require 'spec_helper'

describe CssRule do
  
  let(:style_text) do 
    "#main .body a:link { font-weight: bold; text-decoration: none }"
  end

  let(:charset_text) do 
    "@charset \"UTF-8\""
  end

  let(:media_text) do 
    "@media only screen and (max-width: 850px) { 
      #main .section { font-weight: bold; } 
    }"
  end

  let(:import_text) do 
    "@import url(\"import1.css\");"
  end

  let(:font_face_text) do 
    "@font-face {
      font-family: \"Bitstream Vera Serif Bold\";
      src: url(\"http://example.com/fonts/VeraSeBd.ttf\");
    }"
  end

  describe ".factory" do 
    it "should build an a css style rule" do 
      rule = CssRule.factory(:css_text           => style_text, 
                             :parent_style_sheet => Object.new)
      expect(rule).to be_kind_of(CssStyleRule)
    end

    it "should build an a css charset rule" do 
      rule = CssRule.factory(:css_text           => charset_text, 
                             :parent_style_sheet => Object.new)
      expect(rule).to be_kind_of(CssCharsetRule)
    end

    it "should build an a css media rule" do 
      rule = CssRule.factory(:css_text           => media_text, 
                             :parent_style_sheet => Object.new)
      expect(rule).to be_kind_of(CssMediaRule)
    end

    it "should build an a css import rule" do 
      parent = CssStyleSheet.new("http://example.com/css/stylesheets/screen.css")
      rule = CssRule.factory(:css_text           => import_text, 
                             :parent_style_sheet => parent)
      expect(rule).to be_kind_of(CssImportRule)
    end

    it "should build an a css font-face rule" do 
      rule = CssRule.factory(:css_text           => font_face_text, 
                             :parent_style_sheet => Object.new)
      expect(rule).to be_kind_of(CssFontFaceRule)
    end
  end

  describe "#css_text" do 
    it "returns full css text for the given rule" do 
      rule = CssRule.factory(:css_text           => style_text, 
                             :parent_style_sheet => Object.new)

      expect(rule.css_text).to eq style_text
    end
  end

  describe "#parent_style_sheet" do     
    it "refers back to the parent style sheet" do 
      rule = CssRule.factory(:css_text           => style_text, 
                             :parent_style_sheet => Object.new)

      expect(rule.parent_style_sheet).to be
    end
  end

  describe "#parent_rule" do 
    it "is empty when not a child of a media rule" do 
      css_text = "#main .body a:link { font-weight: bold; text-decoration: none }"
      rule     = CssStyleRule.new(:css_text => css_text)

      expect(rule.parent_rule).to eq nil
    end

    it "refers back to the parent rule for media rules" do 
      parent = CssRule.factory(:css_text           => media_text, 
                               :parent_style_sheet => Object.new)
      
      rule = CssRule.factory(:css_text           => style_text, 
                             :parent_style_sheet => Object.new, 
                             :parent_rule        => parent)

      expect(rule.parent_rule).to eq parent
    end
  end


end