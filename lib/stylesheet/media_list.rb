module Stylesheet
  class MediaList
    extend Forwardable
    def_delegators :@styles, :length, :[], :each
    include Enumerable
    
    def initialize(media)
      @medias = []
    end
    
    def item(index)
      @medias[index]
    end
  end
end