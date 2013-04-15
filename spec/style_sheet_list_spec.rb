require 'spec_helper'

describe StyleSheetList do 
  before(:each) do 
    Stylesheet.request = FakeRequest.new
  end
  
  let(:external) do 
    { href: "http://example.com/css/stylesheets/colors.css", media: "screen" }
  end

  let(:inline) do 
    { content: "div {\n  background-color: #aaa;\n  border: 1px solid #ccc;\n}"}
  end

  describe ".new" do 
    it "should initialize a new style sheet list " do 
      stylesheets = StyleSheetList.new([external, inline])
      expect(stylesheets).to be_kind_of(StyleSheetList)
    end
  end
  
  describe "#[]" do 
    it "finds a css style sheet at the given index" do 
      stylesheets = StyleSheetList.new([external, inline])
      expect(stylesheets[0]).to be_kind_of(CssStyleSheet)
    end
  end
  
  describe "#each" do 
    it "iterates over each style sheet" do 
      stylesheets = StyleSheetList.new([external, inline])

      i = 0
      stylesheets.each {|stylesheet| i += 1 }
      expect(i).to eq 2
    end
  end
  
  describe "#length" do 
    it "returns number of items" do 
      stylesheets = StyleSheetList.new([external, inline])
      expect(stylesheets.length).to eq 2
    end
  end
  
  describe "#item" do 
    it "finds a css style sheet at the given index" do 
      stylesheets = StyleSheetList.new([external, inline])
      expect(stylesheets.item(0)).to be_kind_of(CssStyleSheet)
    end
  end
end