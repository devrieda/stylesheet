module Stylesheet
  class MediaList
    extend Forwardable
    def_delegators :@media, :length, :size, :[], :each, :<<, :push, :delete, :to_s
    include Enumerable

    MEDIA_TYPES = %w{all braille embossed handheld print projection screen speech tty tv}

    def initialize(media_text)
      @media = media_text.to_s.split(",").map {|medium| medium.strip }
    end

    def item(index)
      @media[index]
    end

    def media_text
      @media.join(", ")
    end
    
    alias_method :to_s, :media_text
    
    alias_method :append_medium, :<<
    alias_method :delete_medium, :delete    
  end
end