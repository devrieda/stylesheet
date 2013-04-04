require 'spec_helper'

describe Stylesheet::VERSION do 
  describe "version" do 
    it "should be present" do 
      Stylesheet::VERSION.should_not be_nil
    end
  end
end