require 'spec_helper'

describe Location do 
  let(:url) { "http://initvisual.com:80/services?foo=bar#abc" }

  describe "#new" do 
    it "should parse out parts of url" do 
      location = Location.new(url)
      expect(location.host).to eq "initvisual.com"
    end
    
    it "should accept relative urls" do 
      location = Location.new("/some/path.html")
      expect(location.to_s).to eq "/some/path.html"
    end
  end
  
  describe "#host" do 
    it "should parse out the url host" do 
      location = Location.new(url)
      expect(location.host).to eq "initvisual.com"
    end
  end
  
  describe "#host=" do 
    it "should assign host to url" do 
      location = Location.new(url)
      
      location.host = "derekdevries.com"
      expect(location.host).to eq "derekdevries.com"
    end
  end
  
  describe "#hostname" do 
    it "should parse out the url hostname" do 
      location = Location.new(url)
      expect(location.hostname).to eq "initvisual.com"
    end
  end
  
  describe "#hostname=" do 
    it "should assign hostname to url" do 
      location = Location.new(url)
      
      location.hostname = "derekdevries.com"
      expect(location.hostname).to eq "derekdevries.com"
    end
  end

  describe "#pathname" do 
    it "should parse out the url pathname" do 
      location = Location.new(url)
      expect(location.pathname).to eq "/services"
    end
  end

  describe "#pathname=" do 
    it "should assign path to url" do 
      location = Location.new(url)
      
      location.pathname = "/work"
      expect(location.pathname).to eq "/work"
    end

    it "add initial forward-slash if not given" do 
      location = Location.new(url)
      
      location.pathname = "work"
      expect(location.pathname).to eq "/work"
    end
  end

  describe "#hash" do 
    it "should parse out the url hash" do 
      location = Location.new(url)
      expect(location.hash).to eq "#abc"
    end
  end
  
  describe "#hash=" do 
    it "should assign hash to url" do 
      location = Location.new(url)
      
      location.hash = "#def"
      expect(location.hash).to eq "#def"
    end
    
    it "add hash character if not given" do 
      location = Location.new(url)
      
      location.hash = "def"
      expect(location.hash).to eq "#def"
    end
  end
    
  describe "#protocol" do 
    it "should parse out the url protocol" do 
      location = Location.new(url)
      expect(location.protocol).to eq "http:"
    end
  end
  
  describe "#protocol=" do 
    it "should assign protocol to url" do 
      location = Location.new(url)
      
      location.protocol = "https:"
      expect(location.protocol).to eq "https:"
    end
    
    it "add colon character if not given" do 
      location = Location.new(url)

      location.protocol = "https"
      expect(location.protocol).to eq "https:"
    end
  end

  describe "#search" do 
    it "should parse out the url query string" do 
      location = Location.new(url)
      expect(location.search).to eq "?foo=bar"
    end
  end
  
  describe "#search=" do 
    it "should assign query string to url" do 
      location = Location.new(url)
      
      location.search = "?bar=baz"
      expect(location.search).to eq "?bar=baz"
    end
    
    it "add question mark to query string if not given" do 
      location = Location.new(url)

      location.search = "bar=baz"
      expect(location.search).to eq "?bar=baz"
    end
  end

  describe "#href" do 
    it "should show the stringified version of the url" do 
      location = Location.new(url)
      expect(location.href).to eq "http://initvisual.com/services?foo=bar#abc"
    end
  end

  describe "#port" do 
    it "should parse out the url port" do 
      url = "http://initvisual.com:8080/services?foo=bar#abc"
      location = Location.new(url)
      expect(location.port).to eq "8080"
    end
    
    it "should ignore port 80 on http" do 
      url = "http://initvisual.com:80/services?foo=bar#abc"
      location = Location.new(url)
      expect(location.port).to eq ""
    end
    
    it "should show port 80 on https" do 
      url = "https://initvisual.com:80/services?foo=bar#abc"
      location = Location.new(url)
      expect(location.port).to eq "80"
    end
    
    it "should ignore port 443 on https" do 
      url = "https://initvisual.com:443/services?foo=bar#abc"
      location = Location.new(url)
      expect(location.port).to eq ""
    end

    it "should show port 443 on http" do 
      url = "http://initvisual.com:443/services?foo=bar#abc"
      location = Location.new(url)
      expect(location.port).to eq "443"
    end
  end


  describe "#to_s" do 
    it "should rebuild url from parts" do 
      u = "http://initvisual.com:8080/services?foo=bar#abc"
      location = Location.new(u)
      expect(location.to_s).to eq u
    end

    it "should ignore hash if no hash present" do 
      url = "http://initvisual.com/services?foo=bar#abc"
      location = Location.new(url)
      location.hash = ""
      expect(location.to_s).to eq "http://initvisual.com/services?foo=bar"
    end

    it "should ignore port if no port present" do
      url = "https://initvisual.com/services?foo=bar#abc"
      location = Location.new(url)
      expect(location.to_s).to eq url
    end
    
    it "should ignore query string if no query string present" do 
      url = "https://initvisual.com/services"
      location = Location.new(url)
      expect(location.to_s).to eq url
    end

    it "should ignore scheme if no protocol is present" do 
      url = "/services"
      location = Location.new(url)
      expect(location.to_s).to eq url
    end
  end
  
end