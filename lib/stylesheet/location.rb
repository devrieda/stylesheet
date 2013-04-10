module Stylesheet
  class Location
    attr_accessor :uri, :host, :href
    attr_reader :hash, :pathname, :port, :protocol, :search

    alias_method :hostname,  :host
    alias_method :hostname=, :host=

    def initialize(url)      
      @uri  = parse_uri(url)
      @host = uri.host

      self.pathname = uri.path
      self.hash     = uri.fragment
      self.protocol = uri.scheme
      self.search   = uri.query
      self.port     = uri.port
    end

    def protocol=(protocol)
      protocol = protocol.to_s.gsub(":", "")
      @protocol = "#{protocol}:"
    end

    def pathname=(pathname)
      @pathname = pathname && pathname[0,1] == "/" ? pathname : "/#{pathname}"
    end

    def port=(port)
      @port = standard_port? ? "" : "#{port}"
    end

    def search=(search)
      search = search.to_s.gsub("?", "")
      @search = search && search != "" ? "?#{search}" : ""
    end

    def hash=(hash)
      hash = hash.to_s.gsub("#", "")
      @hash = hash && hash != "" ? "##{hash}" : ""
    end

    def valid?
       valid_protocol? && valid_host?
    end

    def to_s
      port_w_colon = port && port != "" ? ":#{port}"      : ""
      scheme       = valid_protocol?    ? "#{protocol}//" : ""

      "#{scheme}#{host}#{port_w_colon}#{pathname}#{search}#{hash}"
    end
    
    alias_method :href, :to_s


    private
    
    def valid_protocol?
      protocol && protocol != ":"
    end
    
    def valid_host?
      host && host != ""
    end
    
    def standard_port?
      port_80? || port_443?
    end
    
    def port_80?
      return false unless uri && uri.scheme
      uri.port == 80 && uri.scheme == "http"
    end

    def port_443?
      return false unless uri && uri.scheme == "https"
      uri.port == 443 && uri.scheme == "https"
    end

    def parse_uri(url)
      uri = begin 
        URI.parse(url.strip)
      rescue URI::InvalidURIError
        URI.parse(URI.escape(url.strip))
      end      

    rescue URI::InvalidURIError => error
      raise Stylesheet::InvalidLocationError.new(
        "#{error.class}: #{error.message}")
    end
    
  end
end

