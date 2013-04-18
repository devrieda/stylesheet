require 'spec_helper'

describe CssRule do
  
  let(:css_text) do 
    "#main .body a:link { font-weight: bold; text-decoration: none }"
  end

  let(:rule) do 
    CssRule.factory(:css_text => css_text, :parent_style_sheet => Object.new)
  end

  describe ".factory" do 
    it "should build an appropriate Css Rule type based on data" do 
      
    end
  end

  describe "#css_text" do 
    it "returns full css text for the given rule" do 
      expect(rule.css_text).to eq css_text
    end
  end

  describe "#parent_style_sheet" do     
    it "refers back to the parent style sheet" do 
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

    end
  end


end