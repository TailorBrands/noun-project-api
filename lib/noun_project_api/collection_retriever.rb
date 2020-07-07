# frozen_string_literal: true

require "noun_project_api/collection"
require "noun_project_api/retriever"

module NounProjectApi
  # Retrieve a collection.
  class CollectionRetriever < Retriever
    API_PATH = "/collection/"
    ITEM_CLASS = Collection

    alias find_by_slug find
  end
end
