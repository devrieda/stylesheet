require 'spec_helper'

describe CssStyleSheet do 
  before(:each) do 
    Stylesheet.request = FakeRequest.new
  end
  
  describe "#disabled" do 
    it "shows if style sheet is disabled" do 
      sheet = CssStyleSheet.new("http://example.com/css/stylesheets/screen.css")
      expect(sheet.disabled?).to eq false

      sheet.disabled = true
      expect(sheet.disabled?).to eq true
    end
  end

  describe ".new" do 
    it "should initialize with inline styles" do 
      css = "div {\n  background-color: #aaa;\n  border: 1px solid #ccc;\n}"
      sheet = CssStyleSheet.new(:content => css)
      expect(sheet.href).to be_nil
    end
    
    it "should initialize with a url string" do 
      url = "http://example.com/css/stylesheets/screen.css"
      sheet = CssStyleSheet.new(url)
      expect(sheet.href).to eq url
    end

    it "should initialize with hash options" do 
      url = "http://example.com/css/stylesheets/screen.css"
      sheet = CssStyleSheet.new(:href => url)
      expect(sheet.href).to eq url
    end
  end
  
  describe "#href" do 
    it "parses the href of the stylesheet for url" do 
      url   = "http://example.com/css/stylesheets/screen.css"
      sheet = CssStyleSheet.new(:href => url)

      expect(sheet.href).to eq url
    end
    
    it "parses the href as nil for inline stylesheets" do 
      css = "div {\n  background-color: #aaa;\n  border: 1px solid #ccc;\n}"
      sheet = CssStyleSheet.new(:content => css)

      expect(sheet.href).to be_nil
    end

    it "parses the href of the stylesheet for relative style path with parent document" do 
      parent = Document.new("http://example.com/css/html5.html")
      path   = "stylesheets/screen.css"
      sheet  = CssStyleSheet.new(:href => path, :parent => parent)

      expect(sheet.href).to eq "http://example.com/css/stylesheets/screen.css"
    end

    it "parses the href of the stylesheet for absolute style path with parent document" do 
      parent = Document.new("http://example.com/css/html5.html")
      path   = "/css/stylesheets/screen.css"
      sheet = CssStyleSheet.new(:href => path, :parent => parent)

      expect(sheet.href).to eq "http://example.com/css/stylesheets/screen.css"
    end

    it "parses the href of the stylesheet for relative style path with parent style" do 
      parent = CssStyleSheet.new("http://example.com/css/stylesheets/screen.css")
      path   = "print.css"
      sheet  = CssStyleSheet.new(:href => path, :parent => parent)

      expect(sheet.href).to eq "http://example.com/css/stylesheets/print.css"    
    end
    
    it "parses the href of the stylesheet for relative root style path with parent style" do
      parent = CssStyleSheet.new("http://example.com/css/stylesheets/screen.css")
      path   = "/css/stylesheets/print.css"
      sheet  = CssStyleSheet.new(:href => path, :parent => parent)

      expect(sheet.href).to eq "http://example.com/css/stylesheets/print.css"      
    end    
  end

  describe "#media" do 
    it "returns the list of media types supported for styles" do 
      sheet = CssStyleSheet.new(:href => "http://example.com/css/stylesheets/screen.css")
      expect(sheet.media).to be_kind_of(MediaList)
    end
  end

  describe "#parent_style_sheet" do 
    let(:parent) do 
      CssStyleSheet.new("http://example.com/css_import/stylesheets/screen.css")
    end

    it "should be nil for non-imported sheets" do 
      expect(parent.parent_style_sheet).to be_nil
    end

    it "references parent style sheet" do 
      text = "@import url(\"import1.css\");" 
      rule = CssImportRule.new(:css_text => text, :parent_style_sheet => parent)

      expect(rule.style_sheet.parent_style_sheet).to eq parent
    end
  end

  describe "#title" do 
    it "returns the title of the stylesheet" do 
      url = "http://example.com/css/stylesheets/screen.css"
      sheet = CssStyleSheet.new(:href => url, :title => "My Styles")
      expect(sheet.title).to eq "My Styles"
    end
  end
  
  describe "#type" do 
    it "returns the type of the stylesheet" do 
      url = "http://example.com/css/stylesheets/screen.css"
      sheet = CssStyleSheet.new(:href => url, :type => "text/css")
      expect(sheet.type).to eq "text/css"
    end
    
    it "defaults to text/css for the type" do 
      sheet = CssStyleSheet.new("http://example.com/css/stylesheets/screen.css")
      expect(sheet.type).to eq "text/css"
    end
  end

  describe "#content" do
    it "doesn't fetch for empty inline styles" do
      sheet = CssStyleSheet.new(content: "")

      expect {
        sheet.css_rules.map {|r| r.content }
      }.not_to raise_error
    end

    it "doesn't fetch for nil inline styles" do
      sheet = CssStyleSheet.new(content: nil)

      expect {
        sheet.css_rules.map {|r| r.content }
      }.not_to raise_error
    end

  end

  describe "#css_rules" do 
    it "returns a list of css rules found in the style sheet" do 
      sheet = CssStyleSheet.new("http://example.com/css/stylesheets/screen.css")
      expect(sheet.css_rules).to be_kind_of(CssRuleList)
    end
  end
  
  describe "#rules" do 
    it "is an alias to css rules" do 
      sheet = CssStyleSheet.new("http://example.com/css/stylesheets/screen.css")
      expect(sheet.rules).to be_kind_of(CssRuleList)
    end
  end
  
  describe "#import_rules" do 
    it "returns all import rules from style sheet" do 
      sheet = CssStyleSheet.new("http://example.com/css_import/stylesheets/screen.css")
      expect(sheet.import_rules.length).to eq 9
      
      sheet.import_rules.each do |rule|
        expect(rule.type).to eq CssRule::IMPORT_RULE
      end
    end
  end
  
  describe "#style_rules" do 
    it "returns all style rules from style sheet" do 
      sheet = CssStyleSheet.new("http://example.com/css_import/stylesheets/screen.css")
      expect(sheet.style_rules.length).to eq 1

      sheet.style_rules.each do |rule|
        expect(rule.type).to eq CssRule::STYLE_RULE
      end
    end
  end
  
  describe "#owner_rule" do 
    let(:parent) do 
      CssStyleSheet.new("http://example.com/css_import/stylesheets/screen.css")
    end

    it "should be nil for non-imported sheets" do 
      expect(parent.owner_rule).to be_nil
    end

    it "references the owner rule" do 
      text = "@import url(\"import1.css\");" 
      rule = CssImportRule.new(:css_text => text, :parent_style_sheet => parent)

      expect(rule.style_sheet.owner_rule).to eq rule
    end
  end
  
  describe "#delete_rule" do 
    it "deletes a rule from the css rules" do 
      css = "div {\n  background-color: #aaa;\n} span {\n  color: #444; \n}"
      sheet = CssStyleSheet.new(:content => css)

      sheet.css_rules
      expect(sheet.css_rules.length).to eq 2

      sheet.delete_rule(0)
      expect(sheet.css_rules.length).to eq 1
      expect(sheet.css_rules[0].css_text).to eq "span { color: #444;}"
    end
  end
  
  describe "#insert_rule" do 
    it "adds a rule to the css rules" do 
      css = "div {\n  background-color: #aaa;\n} span {\n  color: #444; \n}"
      sheet = CssStyleSheet.new(:content => css)

      expect(sheet.css_rules.length).to eq 2

      sheet.insert_rule("#blanc { color: white }", 0); 
      expect(sheet.css_rules.length).to eq 3
      
    end
  end
end
