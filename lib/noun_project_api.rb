# frozen_string_literal: true

require "oauth"
require "active_support"
require "json"
require "noun_project_api/errors"
require "noun_project_api/connection"
require "noun_project_api/icon_retriever"
require "noun_project_api/reporter"
require "noun_project_api/icons_retriever"
require "noun_project_api/icon"
require "noun_project_api/collection_retriever"
require "noun_project_api/collection"

# Top level name space for the entire Gem.
module NounProjectApi
  API_BASE = "http://api.thenounproject.com"

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration) if block_given?
  end

  # Main configuration class.
  class Configuration
    attr_accessor :public_domain, :cache

    def initialize
      @public_domain = false
      @cache = ActiveSupport::Cache::NullStore.new
    end
  end
end
