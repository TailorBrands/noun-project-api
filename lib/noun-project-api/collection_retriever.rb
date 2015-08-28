require 'noun-project-api/retriever'

module NounProjectApi
  # Retrieve a collection.
  class CollectionRetriever < Retriever
    API_PATH = '/collection/'

    # Find a collection based on its id.
    def find(id)
      fail(ArgumentError, 'Missing id/slug') unless id

      result = access_token.get("#{API_BASE}#{API_PATH}#{id}")
      fail(ArgumentError, 'Bad request') unless result.code == '200'

      Collection.new(result.body)
    end

    alias_method :find_by_slug, :find
  end
end
