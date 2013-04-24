require 'spec_helper'

describe CssStyleDeclaration do 
  let(:css_text) do 
    "color: #444;
     font-size: 12px;
     font-family: Arial, Verdana;
     border-left: 1px solid red;
     border-right-width: 1px;
     background-color: #535353;"
  end

  let(:rule) do 
    CssStyleRule.new(:css_text => "div.section { #{css_text} }")
  end

  let(:declaration) do 
    CssStyleDeclaration.new(:css_text => css_text, :parent_rule => rule)
  end


  describe "#length" do 
    it "returns number of declarations" do 
      expect(declaration.length).to eq 6
    end
  end

  describe "#[]" do 
    it "finds name of a declaration for given index" do 
      expect(declaration[1]).to eq "font-size: 12px"
    end
  end

  describe "#css_text" do 
    it "builds the css text from the declarations" do 
      expected = "color: #444; font-size: 12px; font-family: Arial, Verdana; " + 
                 "border-left: 1px solid red; border-right-width: 1px; " + 
                 "background-color: #535353;"

      expect(declaration.css_text).to eq expected
    end
  end

  
  describe "#parent_rule" do 
    it "returns the parent css style rule" do 
      expect(declaration.parent_rule).to eq rule
    end
  end

  describe "a declaration" do 
    it "finds a declaration value by name" do 
      
    end
  end
end
