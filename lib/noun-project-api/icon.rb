require 'noun-project-api/retriever'

module NounProjectApi
  class Icon < Retriever
    API_PATH = "/icon/"

    def find(id)
      raise ArgumentError unless id

      result = self.access_token.get("#{API_BASE}#{API_PATH}#{id}")
      raise ArgumentError unless result.code == '200'

      JSON.parse(result.body)
    end

    def find_by_slug(slug)
      raise ArgumentError unless slug

      result = self.access_token.get("#{API_BASE}#{API_PATH}#{slug}")
      raise ArgumentError unless result.code == '200'

      JSON.parse(result.body)
    end
  end
end
