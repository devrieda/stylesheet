require 'spec_helper'

describe CssImportRule do
  let(:css_text) { "@import url(\"import1.css\");" }

  let(:rule) do 
    CssImportRule.new(:css_text => css_text)
  end

  describe "#type" do 
    it "shows the type of style rule" do 
      expect(rule.type).to eq CssRule::IMPORT_RULE
    end
  end

  describe "#href" do  
    let(:parent) do 
      CssStyleSheet.new("http://example.com/css_import/stylesheets/screen.css")
    end
    
    let(:rule_url) { "http://example.com/css_import/stylesheets/import1.css"  }
    
    it "parses an url from the style rule" do 
      css_text = "@import url(\"http://example.com/css_import/stylesheets/import1.css\");" 
    
      rule = CssImportRule.new(:css_text => css_text, :parent_style_sheet => parent)
      expect(rule.href).to eq "http://example.com/css_import/stylesheets/import1.css"
      expect(rule.location.href).to eq rule_url
    end

    it "parses an absolute path from the style rule" do 
      css_text = "@import url(\"/css_import/stylesheets/import1.css\");" 

      rule = CssImportRule.new(:css_text => css_text, :parent_style_sheet => parent)
      expect(rule.href).to eq '/css_import/stylesheets/import1.css'
      expect(rule.location.href).to eq rule_url
    end

    it "parses a relative path with double quotes from the style rule" do 
      css_text = "@import url(\"import1.css\");" 
    
      rule = CssImportRule.new(:css_text => css_text, :parent_style_sheet => parent)
      expect(rule.href).to eq "import1.css"
      expect(rule.location.href).to eq rule_url
    end
    
    it "parses a relative path with single quotes from the style rule" do 
      css_text = "@import url(\"import1.css\");" 
    
      rule = CssImportRule.new(:css_text => css_text, :parent_style_sheet => parent)
      expect(rule.href).to eq "import1.css"
      expect(rule.location.href).to eq rule_url
    end
    
    it "parses a relative path with single medium from the style rule" do 
      css_text = '@import url("import1.css") print;'
    
      rule = CssImportRule.new(:css_text => css_text, :parent_style_sheet => parent)
      expect(rule.href).to eq "import1.css"
      expect(rule.location.href).to eq rule_url
    end
    
    it "parses a relative path with multiple media from the style rule" do 
      css_text = '@import url("import1.css") screen,projection;'
    
      rule = CssImportRule.new(:css_text => css_text, :parent_style_sheet => parent)
      expect(rule.href).to eq "import1.css"
      expect(rule.location.href).to eq rule_url
    end
    
    it "parses a relative path with media and orientation from the style rule" do 
      css_text = '@import url("import1.css") screen and (orientation:landscape);'
    
      rule = CssImportRule.new(:css_text => css_text, :parent_style_sheet => parent)
      expect(rule.href).to eq "import1.css"
      expect(rule.location.href).to eq rule_url
    end
    
    it "parses a relative path without url from the style rule" do 
      css_text = '@import "import1.css";'
    
      rule = CssImportRule.new(:css_text => css_text, :parent_style_sheet => parent)
      expect(rule.href).to eq "import1.css"
      expect(rule.location.href).to eq rule_url
    end
    
    it "parses a relative path without url and single medium from the style rule" do 
      css_text = '@import "import1.css" screen;'
    
      rule = CssImportRule.new(:css_text => css_text, :parent_style_sheet => parent)
      expect(rule.href).to eq "import1.css"
      expect(rule.location.href).to eq rule_url
    end
    
    it "parses a relative path without url and multiple media from the style rule" do 
      css_text = '@import "import1.css" screen, projection;'
    
      rule = CssImportRule.new(:css_text => css_text, :parent_style_sheet => parent)
      expect(rule.href).to eq "import1.css"
      expect(rule.location.href).to eq rule_url
    end
    
    it "parses a relative path with an invalid url from the style rule" do 
      css_text = '@import url("invalid.css");'
    
      rule = CssImportRule.new(:css_text => css_text, :parent_style_sheet => parent)
      expect(rule.href).to eq "invalid.css"
      expect(rule.location.href).to eq "http://example.com/css_import/stylesheets/invalid.css"
    end

  end

  describe "#style_sheet" do 
  end
  
  describe "#media" do 
  end
  
  describe ".matches_rule?" do 
    it "should match text starting with @import" do 
      matches = CssImportRule.matches_rule?(css_text)
      expect(matches).to be_true
    end
    
    it "should not match text without at-rule" do 
      matches = CssImportRule.matches_rule?("a:link { color: #357ad1; }")
      expect(matches).to be_false
    end

    it "should not match text without import" do 
      matches = CssImportRule.matches_rule?("@charset \"UTF-8\";")
      expect(matches).to be_false
    end
  end
end