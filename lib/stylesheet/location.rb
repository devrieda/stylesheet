module Stylesheet
  class Location
    attr_accessor :uri, :hash, :host, :href, :pathname, :port, :protocol, :search
    alias_method :hostname,  :host
    alias_method :hostname=, :host=

    def initialize(url)      
      @href     = url
      @uri      = parse_uri(url)
      @host     = uri.host

      self.pathname = uri.path
      self.hash     = uri.fragment
      self.protocol = uri.scheme
      self.search   = uri.query
      self.port     = uri.port
    end
    
    def pathname=(pathname)
      @pathname = pathname && pathname[0,1] == "/" ? pathname : "/#{pathname}"
    end
    
    def hash=(hash)
      hash = hash.to_s.gsub("#", "")
      @hash = hash && hash != "" ? "##{hash}" : ""
    end

    def protocol=(protocol)
      protocol = protocol.to_s.gsub(":", "")
      @protocol = protocol + ":"
    end
    
    def search=(search)
      search = search.to_s.gsub("?", "")
      @search = search && search != "" ? "?#{search}" : ""
    end

    def port=(port)
      @port = port_80? || port_443? ? "" : "#{port}"
    end

    def port_80?
      return false unless uri && uri.scheme
      uri.port == 80 && uri.scheme == "http"
    end

    def port_443?
      return false unless uri && uri.scheme == "https"
      uri.port == 443 && uri.scheme == "https"
    end

    def to_s
      port_w_colon = port && port != "" ? ":#{port}" : ""
      "#{protocol}//#{host}#{port_w_colon}#{pathname}#{search}#{hash}"
    end


    private
    
    def parse_uri(url)
      URI.parse(url.strip)
    rescue URI::InvalidURIError
      URI.parse(URI.escape(url.strip))
    end
    
  end
end

