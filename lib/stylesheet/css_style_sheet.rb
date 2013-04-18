module Stylesheet
  class CssStyleSheet
    attr_accessor :parent, :title
    attr_reader :url, :href, :media, :content
    attr_writer :disabled, :type
    
    def initialize(args)
      if args.kind_of?(String)
        init_with_url(args)
      else
        init_with_hash(args)
      end
    end
    
    def init_with_url(url)
      self.href    = url
      self.media   = ""
      self.content = nil
    end
    
    def init_with_hash(args)
      @parent  = args[:parent]
      @title   = args[:title]
      @type    = args[:type]

      self.href    = args[:href]
      self.media   = args[:media]
      self.content = args[:content]
    end

    def disabled?
      @disabled || false
    end
    
    def type
      @type || "text/css"
    end
    
    def href=(url)
      @url  = url
      @href = build_href(url)
    end
    
    def media=(media)
      @media ||= MediaList.new(media)
    end
    
    def content=(content)
      @content = content || request_content
    end

    def css_rules
      @css_rules ||= CssRuleList.new(content)
    end
    
    alias_method :rules, :css_rules 

    def parent_style_sheet
      parent
    end
    
    def location
      @location ||= if standalone_css?
        Location.new(url)

      elsif inline_css?
        parent.location.dup

      else
        expanded_location(url)
      end
    end
    

    private

    # expand path of url based on parent url
    def expanded_location(url)
      location = Location.new(url)
      location.expand_path!(parent.location)
      location      
    end

    def build_href(url)
      return if !parent && empty_url?
      location.to_s
    end

    def standalone_css?
      !parent
    end
    
    def inline_css?
      empty_url?
    end
    
    def empty_url?
      !url || url == ""
    end

    def request_content
      raise InvalidLocationError unless location.valid?
      request.get(location.href)
    end

    def request
      @request ||= Stylesheet.request
    end
  end
end