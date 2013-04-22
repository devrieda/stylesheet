module Stylesheet
  class CssStyleSheet
    attr_accessor :parent, :title
    attr_reader :href, :media, :content
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
      
      self.href     = args[:href]
      self.location = args[:location]
      self.media    = args[:media]
      self.content  = args[:content]
    end

    def disabled?
      @disabled || false
    end
    
    def type
      @type || "text/css"
    end
    
    def href=(url)
      return unless url
      @url  = url
      @href = location.to_s
    end
    
    def media=(media)
      @media ||= MediaList.new(media)
    end
    
    def content=(content)
      @content = content || request_content
    end

    def css_rules
      @css_rules ||= CssRuleList.new(content, self)
    end

    alias_method :rules, :css_rules 

    def parent_style_sheet
      parent
    end
    
    def location
      return if inline_css?
      @location ||= Location.new(@url, parent && parent.location)
    end
    
    def location=(location)
      return unless location

      @location = location
      @url      = location.href
      @href     = location.href
    end

    private

    def standalone_css?
      !parent
    end
    
    def inline_css?
      !@url || @url == ""
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