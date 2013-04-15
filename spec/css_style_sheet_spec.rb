require 'spec_helper'

describe CssStyleSheet do 
  
  describe "#disabled" do 
    it "shows if style sheet is disabled" do 
      sheet = CssStyleSheet.new("http://example.com/css/stylesheets/screen.css")
      expect(sheet.disabled?).to be_false

      sheet.disabled = true
      expect(sheet.disabled?).to be_true
    end
  end

  describe ".new" do 
    it "should initialize with no url" do 
      css = "div {\n  background-color: #aaa;\n  border: 1px solid #ccc;\n}"
      sheet = CssStyleSheet.new(content: css)
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
    it "parse the href of the stylesheet for url" do 
      url   = "http://example.com/css/stylesheets/screen.css"
      sheet = CssStyleSheet.new(:href => url)

      expect(sheet.href).to eq url
    end
    
    it "parse the href of the stylesheet for relative style path with parent document" do 
      parent = Document.new("http://example.com/css/html5.html")
      path   = "stylesheets/screen.css"
      sheet  = CssStyleSheet.new(:href => path, :parent => parent)

      expect(sheet.href).to eq "http://example.com/css/stylesheets/screen.css"
    end

    it "parse the href of the stylesheet for absolute style path with parent document" do 
      parent = Document.new("http://example.com/css/html5.html")
      path   = "/css/stylesheets/screen.css"
      sheet = CssStyleSheet.new(:href => path, :parent => parent)

      expect(sheet.href).to eq "http://example.com/css/stylesheets/screen.css"
    end

    it "parse the href of the stylesheet for relative style path with parent style" do 
      parent = CssStyleSheet.new("http://example.com/css/stylesheets/screen.css")
      path   = "print.css"
      sheet  = CssStyleSheet.new(:href => path, :parent => parent)

      expect(sheet.href).to eq "http://example.com/css/stylesheets/print.css"    
    end
    
    it "parse the href of the stylesheet for relative root style path with parent style" do
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

  describe "#owner_node" do 
    it "references owning node" do 

    end
  end
  
  describe "#parent_style_sheet" do 
    it "references parent style sheet" do 

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
  
  describe "#css_rules" do 
    it "returns a list of css rules found in the style sheet" do 
      # .to be_kind_of(CSSRuleList)
    end
  end
  
  describe "#rules" do 
    it "is an alias to css rules" do 
      # .to be_kind_of(CSSRuleList)
    end
  end
  
  describe "#owner_rule" do 
    it "references the owner rule" do 

    end
  end
  
  describe "#delete_rule" do 
    it "deletes a rule from the css rules" do 

    end
  end
  
  describe "#insert_rule" do 
    it "adds a rule to the css rules" do 

    end
  end
end