module Stylesheet
  class CssStyleSheet
    attr_accessor :url, :parent
    attr_reader :href, :location
    attr_writer :disabled
    
    def initialize(args)
      @parent   = args[:parent]
      self.href = args[:href]
    end

    def disabled?
      @disabled || false
    end
    
    def href=(url)
      @href = build_href(url)
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