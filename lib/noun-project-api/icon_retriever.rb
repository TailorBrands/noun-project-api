require 'noun-project-api/retriever'

module NounProjectApi
  class IconRetriever < Retriever
    API_PATH = "/icon/"

    def find(id)
      raise ArgumentError.new('Missing id/slug') unless id

      result = self.access_token.get("#{API_BASE}#{API_PATH}#{id}")
      raise ArgumentError.new('Bad request') unless result.code == '200'

      JSON.parse(result.body)["icon"]
    end

    alias_method :find_by_slug, :find
  end
end
