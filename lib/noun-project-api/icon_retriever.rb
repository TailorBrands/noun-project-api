require 'noun-project-api/icon'
require 'noun-project-api/retriever'

module NounProjectApi
  # Retrieve an icon.
  class IconRetriever < Retriever
    API_PATH = '/icon/'
    ITEM_CLASS = Icon

    alias_method :find_by_slug, :find
  end
end
