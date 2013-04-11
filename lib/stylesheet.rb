require 'uri'
require 'curb'
require 'nokogiri'

require 'stylesheet/errors'
require 'stylesheet/version'
require 'stylesheet/document'
require 'stylesheet/location'
require 'stylesheet/style_sheet_list'
require 'stylesheet/css_style_sheet'
require 'stylesheet/media_list'
require 'stylesheet/css_rule_list'
require 'stylesheet/css_style_rule'
require 'stylesheet/css_style_declaration'

module Stylesheet

  def self.request=(request)
    @request = request
  end

  def self.request
    @request ||= Request.new
  end

  # Request an asset
  #
  class Request
    def get(url)
      curl = Curl::Easy.perform(url) do |curl| 
        curl.headers["User-Agent"] = user_agent
        curl.follow_location       = true
      end

      curl.body_str

    rescue Stylsheet::Error
      raise

    # re-raise external library errors in our namespace
    rescue => error
      raise Stylsheet::Error.new("#{error.class}: #{error.message}")
    end

    def user_agent
      "Ruby/Stylesheet Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.8.0.7) Gecko/20060909 Firefox/1.5.0.7"
    end
  end
end
