require 'spec_helper'

describe Document do 
  describe "#style_sheets" do 
    before do 
      @request = FakeRequest.new
    end

    it "parse a style sheet list collection from absolute path" do
      text = @request.get("http://example.com/css/absolute.html")
      # doc  = Document.new(text)
      # doc.style_sheet_list.should be_kind_of(StyleSheetList)
    end

    it "parse a style sheet list collection from inline path" do
      text = @request.get("http://example.com/css/inline.html")
      # doc  = Document.new(text)
      # .should be_kind_of(StyleSheetList)
    end
    
    it "parse a style sheet list collection from inline import path" do
      text = @request.get("http://example.com/css/inline_import.html")
      # doc  = Document.new(text)
      # .should be_kind_of(StyleSheetList)
    end

    it "parse a style sheet list collection from invalid path" do
      text = @request.get("http://example.com/css/invalid.html")
      # doc  = Document.new(text)
      # .should be_kind_of(StyleSheetList)
    end

    it "parse a style sheet list collection from relative path" do
      text = @request.get("http://example.com/css/relative.html")
      # doc  = Document.new(text)
      # .should be_kind_of(StyleSheetList)
    end

    it "parse a style sheet list collection from relative root path" do
      text = @request.get("http://example.com/css/relative_root.html")
      # doc  = Document.new(text)
      # .should be_kind_of(StyleSheetList)
    end
  end
end