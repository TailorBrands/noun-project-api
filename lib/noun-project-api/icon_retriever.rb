require 'noun-project-api/retriever'

module NounProjectApi
  # Retrieve an icon.
  class IconRetriever < Retriever
    API_PATH = '/icon/'

    # Find an icon based on it's id.
    def find(id)
      fail(ArgumentError, 'Missing id/slug') unless id

      result = access_token.get("#{API_BASE}#{API_PATH}#{id}")
      fail(ArgumentError, 'Bad request') unless result.code == '200'

      Icon.new(result.body)
    end

    alias_method :find_by_slug, :find
  end
end
