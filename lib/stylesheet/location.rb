module Stylesheet
  class Location
    attr_accessor :uri, :host, :href
    attr_reader :hash, :pathname, :port, :protocol, :search

    alias_method :hostname,  :host
    alias_method :hostname=, :host=

    def initialize(url)      
      @uri  = parse_uri(url)
      @host = uri.host
      
      self.init_from_uri
    end
    
    def init_from_uri
      self.protocol = uri.scheme
      self.pathname = uri.path
      self.port     = uri.port
      self.search   = uri.query
      self.hash     = uri.fragment
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
    
    def expand_path!(parent_location)
      return if valid_protocol?

      self.pathname = URI.join(parent_location.to_s, uri.path).path
      self.protocol = parent_location.protocol
      self.host     = parent_location.host
    end

    def href
      port_w_colon = port && port != "" ? ":#{port}"      : ""
      scheme       = valid_protocol?    ? "#{protocol}//" : ""

      "#{scheme}#{host}#{port_w_colon}#{pathname}#{search}#{hash}"
    end
    
    alias_method :to_s, :href


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
      uri && uri.port == 80 && uri.scheme == "http"
    end

    def port_443?
      uri && uri.port == 443 && uri.scheme == "https"
    end

    def parse_uri(url)
      uri = begin 
        URI.parse(url.strip)
      rescue URI::InvalidURIError
        URI.parse(URI.escape(url.strip))
      end      

    # re-raise external library errors in our namespace
    rescue URI::InvalidURIError => error
      raise Stylesheet::InvalidLocationError.new(
        "#{error.class}: #{error.message}")
    end
    
  end
end

