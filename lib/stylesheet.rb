require 'uri'
require 'forwardable'
require 'curb'
require 'nokogiri'

require 'stylesheet/errors'
require 'stylesheet/version'
require 'stylesheet/inflector'
require 'stylesheet/request'
require 'stylesheet/document'
require 'stylesheet/location'

require 'stylesheet/style_sheet_list'
require 'stylesheet/css_style_sheet'
require 'stylesheet/media_list'

require 'stylesheet/css_rule_list'
require 'stylesheet/css_rule'
require 'stylesheet/css_style_rule'
require 'stylesheet/css_charset_rule'
require 'stylesheet/css_import_rule'
require 'stylesheet/css_media_rule'
require 'stylesheet/css_font_face_rule'
require 'stylesheet/css_null_rule'

require 'stylesheet/css_style_declaration'

module Stylesheet
  def self.request=(request)
    @request = request
  end

  def self.request
    @request ||= Request.new
  end
end
