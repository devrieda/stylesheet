module Stylesheet
  class CssStyleSheet
    attr_accessor :url, :parent, :title
    attr_reader :href, :media, :location
    attr_writer :disabled, :type
    
    def initialize(args)
      if args.kind_of?(String)
        init_with_url(args)
      else
        init_with_hash(args)
      end
    end
    
    def init_with_url(url)
      self.media = ""
      self.href  = url
    end
    
    def init_with_hash(args)
      @parent = args[:parent]
      @title  = args[:title]
      @type   = args[:type]

      self.media = args[:media]
      self.href  = args[:href]      
    end

    def disabled?
      @disabled || false
    end
    
    def type
      @type || "text/css"
    end
    
    def href=(url)
      @href = build_href(url)
    end
    
    def media=(media)
      @media ||= MediaList.new(media)
    end
    
    def parent_style_sheet

    end


    private

    def build_href(url)
      url_is_empty = !url || url == ""
      return if !parent && url_is_empty
      
      @location = if !parent
        Location.new(url)

      # use parent's url
      elsif url_is_empty
        parent.location.dup

      # expand path of url based on parent url
      else
        location = Location.new(url)
        location.expand_path!(parent.location)
        location
      end

      @location.to_s
    end

    def request
      @request ||= Stylesheet.request
    end
  end
end