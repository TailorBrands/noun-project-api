module NounProjectApi
  # A single Icon as an abstracted ruby object.
  class Icon
    PREVIEW_SIZE_200 = 200
    PREVIEW_SIZE_42 = 42
    PREVIEW_SIZE_84 = 84

    PUBLIC_DOMAIN_LICENSE = 'public-domain'

    attr_accessor :original_hash

    def initialize(origin)
      origin = JSON.parse(origin) if origin.is_a? String
      origin = origin.delete('icon') if origin.key? 'icon'

      @original_hash = origin
    end

    def id
      original_hash['id'].to_i
    end

    def public_domain?
      original_hash['license_description'] == PUBLIC_DOMAIN_LICENSE
    end

    def svg_url
      original_hash['icon_url']
    end

    def preview_url(size = PREVIEW_SIZE_200)
      if size == PREVIEW_SIZE_200
        original_hash['preview_url']
      else
        original_hash["preview_url_#{size}"]
      end
    end

    def to_hash
      {
        id: id,
        preview_url_200: preview_url(PREVIEW_SIZE_200),
        preview_url_84: preview_url(PREVIEW_SIZE_84),
        preview_url_42: preview_url(PREVIEW_SIZE_42)
      }
    end

    def to_json
      JSON.dump(to_hash)
    end
  end
end
