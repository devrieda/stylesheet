module Stylesheet
  class CssStyleSheet
    attr_accessor :url, :parent, :title, :type
    attr_reader :href, :location
    attr_writer :disabled
    
    def initialize(args)
      if args.kind_of?(String)
        init_with_url(args)
      else
        init_with_hash(args)
      end
    end
    
    def init_with_url(url)
      @type = "text/css"
      self.href = url
    end
    
    def init_with_hash(args)
      @parent = args[:parent]
      @title  = args[:title]
      @type   = args[:type] || "text/css"
      self.href = args[:href]      
    end

    def disabled?
      @disabled || false
    end
    
    def href=(url)
      @href = build_href(url)
    end
    
    def media
      
    end
    
    def parent_style_sheet
    end


    private

    def build_href(url)
      return url unless parent
      
      # use parent's url
      if !url || url == ""
        @location = parent.location.dup
      
      # expand path of url based on parent url
      else
        @location = Location.new(url)
        @location.expand_path!(parent.location)
        @location.to_s
      end
    end
    
    def request
      @request ||= Stylesheet.request
    end
  end
end