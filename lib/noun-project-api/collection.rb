require "noun-project-api/base_item"

module NounProjectApi
  # A single Collection as an abstracted ruby object.
  class Collection < BaseItem
    ITEM_NAME = "collection".freeze

    def author_id
      original_hash["author_id"].to_i
    end

    def author_name
      original_hash["author"]["name"]
    end

    def icon_count
      original_hash["icon_count"].to_i
    end

    def is_published?
      original_hash["is_published"].to_i == 1
    end

    def to_hash
      {
        id: id,
        author_id: author_id,
        author_name: author_name,
        icon_count: icon_count,
        is_published: is_published?
      }
    end
  end
end
