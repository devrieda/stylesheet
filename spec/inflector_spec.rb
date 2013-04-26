require 'spec_helper'

describe Inflector do 
  describe ".camelize" do 
    it "should camelize a dashed css property" do 
      dashed = "background-color"
      expect(Inflector.camelize(dashed)).to eq "backgroundColor"
    end
  end
  
  describe ".dasherize" do 
    it "should dasherize camelized css property" do 
      camelized = "backgroundColor"
      expect(Inflector.dasherize(camelized)).to eq "background-color"
    end
  end
end