require 'spec_helper'

describe Document do 
  before(:each) do 
    Stylesheet.request = FakeRequest.new
  end

  describe "#location" do 
    it "should build a new Location object from the url" do 
      url = "http://example.com/css/absolute.html"
      doc = Document.new(url)

      expect(doc.location).to be_kind_of(Location)
      expect(doc.location.href).to eq url
    end

    it "should build location from invalid url" do 
      doc = Document.new("asdf")
      expect(doc.location).to be_kind_of(Location)
      expect(doc.location.href).to eq "/asdf"
    end
  end

  describe "#text" do 
    it "should request text for document body" do 
      doc = Document.new("http://example.com/css/absolute.html")

      expect(doc.text).to match /DOCTYPE html/
    end

    it "should thow error if host is invalid" do 
      doc = Document.new("http://")
      expect {
        doc.text
      }.to raise_error(InvalidLocationError)
    end

    it "should thow error if protocol is invalid" do 
      doc = Document.new("foo.com")
      expect {
        doc.text
      }.to raise_error(InvalidLocationError)
    end
  end

  describe "#style_sheets" do 
    it "parses a style sheet list collection from absolute path" do
      doc = Document.new("http://example.com/css/absolute.html")

      expect(doc.style_sheets).to be_kind_of(StyleSheetList)
      expect(doc.style_sheets.length).to eq 2
    end

    it "parses a style sheet list collection from inline path" do
      doc = Document.new("http://example.com/css/inline.html")

      expect(doc.style_sheets).to be_kind_of(StyleSheetList)
      expect(doc.style_sheets.length).to eq 2
    end

    it "parses a style sheet list collection from inline import path" do
      doc = Document.new("http://example.com/css/inline_import.html")

      expect(doc.style_sheets).to be_kind_of(StyleSheetList)
      expect(doc.style_sheets.length).to eq 1
    end

    it "parses a style sheet list collection from invalid path" do
      doc = Document.new("http://example.com/css/invalid.html")

      expect(doc.style_sheets).to be_kind_of(StyleSheetList)
      expect(doc.style_sheets.length).to eq 2
    end

    it "parses a style sheet list collection from relative path" do
      doc = Document.new("http://example.com/css/relative.html")

      expect(doc.style_sheets).to be_kind_of(StyleSheetList)
      expect(doc.style_sheets.length).to eq 2
    end
 
    it "parses a style sheet list collection from relative root path" do
      doc = Document.new("http://example.com/css/relative_root.html")

      expect(doc.style_sheets).to be_kind_of(StyleSheetList)
      expect(doc.style_sheets.length).to eq 2
    end
  end
end