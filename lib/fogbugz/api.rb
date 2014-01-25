require 'open-uri'
require 'ox'

module Fogbugz
  # Your code goes here...
  #
  class Api
    def initialize url, key
      self.url = url
      self.key = key
    end
    attr_accessor :key, :url

    def supported_version?
      result = open("https://#{url}.fogbugz.com/api.xml") do |f|
        f.read
      end
      version = Ox.parse(result)
      (version.response.minversion.text.to_i..version.response.version.text.to_i).include? API_MIN
    end
  end
end
