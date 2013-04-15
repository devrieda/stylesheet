require 'spec_helper'

describe MediaList do 
  
  describe ".new" do 
    it "should parse media list string with no media" do 
      media = MediaList.new("")
      expect(media.length).to eq 0
    end

    it "should parse media list string with single media" do 
      media = MediaList.new("screen")
      expect(media[0]).to eq "screen"
    end

    it "should parse media list string with multiple media" do 
      media = MediaList.new("screen, projection")
      expect(media[0]).to eq "screen"
      expect(media[1]).to eq "projection"
    end
  end

  describe "#[]" do 
    it "finds a media value at the given index" do 
      media = MediaList.new("screen, projection")
      expect(media[0]).to eq "screen"
    end
  end
  
  describe "#each" do 
    it "iterates over each media" do 
      media = MediaList.new("screen, projection")

      i = 0
      media.each {|media| i += 1 }
      expect(i).to eq 2
    end
  end
  
  describe "#length" do 
    it "returns number of items" do 
      media = MediaList.new("screen, projection")
      expect(media.length).to eq 2
    end
  end
  
  describe "#item" do 
    it "finds a media value at the given index" do 
      media = MediaList.new("screen, projection")
      expect(media.item(0)).to eq "screen"
    end
  end


  describe "#media_text" do 
    it "gives the media string value" do 
      media = MediaList.new("screen,projection")
      expect(media.media_text).to eq "screen, projection"
    end
  end

  describe "#to_s" do 
    it "gives the media string value" do 
      media = MediaList.new("screen,projection")
      expect(media.to_s).to eq "screen, projection"
    end
  end

  describe "#delete_medium" do 
    it "deletes a medium from the list of media types" do 
      media = MediaList.new("screen,projection")
      media.delete_medium("screen")
      expect(media.media_text).to eq "projection"
    end
  end

  describe "#delete" do 
    it "deletes a medium from the list of media types" do 
      media = MediaList.new("screen,projection")
      media.delete("screen")
      expect(media.media_text).to eq "projection"
    end
  end
  
  describe "#append_medium" do 
    it "appends a medium to the list of media types" do 
      media = MediaList.new("screen")
      media.append_medium("projection")
      expect(media.media_text).to eq "screen, projection"
    end
  end

  describe "#<<" do 
    it "appends a medium to the list of media types" do 
      media = MediaList.new("screen")
      media << "projection"
      expect(media.media_text).to eq "screen, projection"
    end
  end

  describe "#push" do 
    it "appends a medium to the list of media types" do 
      media = MediaList.new("screen")
      media.push "projection"
      expect(media.media_text).to eq "screen, projection"
    end
  end
end