module NounProjectApi
  # A basis to Items returned by the noun project.
  class BaseItem
    attr_accessor :original_hash
    ITEM_NAME = nil

    def initialize(origin)
      raise NotImplementedError.new("Must use a subclass") if self.class::ITEM_NAME.nil?

      origin = JSON.parse(origin) if origin.is_a? String
      origin = origin.delete(
        self.class::ITEM_NAME
      ) if origin.key? self.class::ITEM_NAME

      @original_hash = origin
    end

    def id
      original_hash["id"].to_i
    end

    def to_json
      JSON.dump(to_hash)
    end
  end
end
