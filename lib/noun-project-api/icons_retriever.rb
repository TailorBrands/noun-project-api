require 'noun-project-api/retriever'
require 'open-uri'

module NounProjectApi
  class IconsRetriever < Retriever
    API_PATH = "/icons/"

    def find(term, limit = nil, offset = nil, page = nil)
      raise ArgumentError.new('Missing search term') unless term

      search = CGI.escape(term)
      search += "?limit_to_public_domain=#{NounProjectApi.configuration.public_domain ? 1 : 0}"

      args = { "limit" => limit, "offset" => offset, "page" => page }.reject { |k, v| v.nil? }
      if args.size > 0
        args.each { |k, v| search += "&#{k}=#{v}" }
      end

      result = self.access_token.get("#{API_BASE}#{API_PATH}#{search}")
      raise ArgumentError.new('Bad request') unless ['200', '404'].include? result.code

      if result.code == '200'
        JSON.parse(result.body)["icons"].map { |icon| Icon.new(icon) }
      else
        []
      end
    end

    def recent_uploads(limit = nil, offset = nil, page = nil)
      args = { "limit" => limit, "offset" => offset, "page" => page }.reject { |k, v| v.nil? }
      if args.size > 0
        search = '?'
        args.each { |k, v| search += "#{k}=#{v}&" }
      else
        search = ''
      end

      result = self.access_token.get("#{API_BASE}#{API_PATH}recent_uploads#{search}")
      raise ArgumentError.new('Bad request') unless result.code == '200'

      JSON.parse(result.body)["recent_uploads"].map { |icon| Icon.new(icon) }
    end
  end
end
