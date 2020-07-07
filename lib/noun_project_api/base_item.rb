# frozen_string_literal: true

module NounProjectApi
  # A basis to Items returned by the noun project.
  class BaseItem
    attr_accessor :original_hash
    ITEM_NAME = nil

    def initialize(origin)
      raise NotImplementedError, "Must use a subclass" if self.class::ITEM_NAME.nil?

      origin = JSON.parse(origin, symbolize_names: true) if origin.is_a? String
      if origin.key? self.class::ITEM_NAME
        origin = origin.delete(
          self.class::ITEM_NAME
        )
      end

      @original_hash = origin
    end

    def id
      original_hash[:id].to_i
    end

    def to_json(*_args)
      JSON.dump(to_hash)
    end
  end
end
