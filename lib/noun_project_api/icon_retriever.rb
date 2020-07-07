# frozen_string_literal: true

require "noun_project_api/icon"
require "noun_project_api/retriever"

module NounProjectApi
  # Retrieve an icon.
  class IconRetriever < Retriever
    API_PATH = "/icon/"
    ITEM_CLASS = Icon

    alias find_by_slug find
  end
end
