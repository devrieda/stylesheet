module Stylesheet
  class Inflector
    def self.camelize(string)
      string.gsub(/(-)(.)/) {|m| m[1].upcase }
    end
    
    def self.dasherize(string)
      string.gsub(/(.)([A-Z])/) {|m| "#{m[0]}-#{m[1].downcase}" }
    end
  end
end