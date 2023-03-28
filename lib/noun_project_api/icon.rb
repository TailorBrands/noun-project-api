# frozen_string_literal: true

require "noun_project_api/base_item"

module NounProjectApi
  # A single Icon as an abstracted ruby object.
  class Icon < BaseItem
    PREVIEW_SIZE_200 = 200
    PREVIEW_SIZE_42 = 42
    PREVIEW_SIZE_84 = 84

    PUBLIC_DOMAIN_LICENSE = "public-domain"

    ITEM_NAME = :icon

    def public_domain?
      original_hash[:license_description] == PUBLIC_DOMAIN_LICENSE
    end

    def svg_url
      original_hash[:icon_url]
    end

    def preview_url(size = PREVIEW_SIZE_200)
      if size == PREVIEW_SIZE_200
        original_hash[:preview_url]
      else
        original_hash[:"preview_url_#{size}"]
      end
    end

    def to_hash
      {
        id:,
        preview_url_200: preview_url(PREVIEW_SIZE_200),
        preview_url_84: preview_url(PREVIEW_SIZE_84),
        preview_url_42: preview_url(PREVIEW_SIZE_42)
      }
    end
  end
end
