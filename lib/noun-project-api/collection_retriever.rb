require 'noun-project-api/collection'
require 'noun-project-api/retriever'

module NounProjectApi
  # Retrieve a collection.
  class CollectionRetriever < Retriever
    API_PATH = '/collection/'
    ITEM_CLASS = Collection

    alias_method :find_by_slug, :find
  end
end
