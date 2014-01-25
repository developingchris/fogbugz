require 'open-uri'
require 'ox'
require 'fogbugz/project'

module Fogbugz
  class Api
    def initialize url, key
      self.url = url
      self.key = key
    end
    attr_accessor :key, :url, :token

    def full_url
      if url =~ /^https/
        url
      else
        "https://#{url}.fogbugz.com"
      end
    end

    def supported_version?
      result = get_xml "#{full_url}/api.xml"
      (result.minversion.text.to_i..result.version.text.to_i).include? API_MIN
    end

    def auth username, password
      resp = get_xml "#{full_url}/api.asp?cmd=logon&email=#{username}&password=#{password}"

      self.token = resp.token.nodes[0].value
      !token.nil?
    end

    def source_checkin

    end

    def projects
      resp = get_xml "#{full_url}/api.asp?token=#{token}&cmd=listProjects"
      projects = []
      resp.projects.nodes do |project|
        projects << Project.build(project)
      end

      projects
    end

    private
    def get_xml request_url, debug=false
      puts request_url if debug
      result = open(request_url) do |f|
        f.read
      end

      puts result if debug
      doc = Ox.parse(result)
      doc.response
    end
  end
end
