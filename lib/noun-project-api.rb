require 'oauth'
require 'json'
require 'noun-project-api/connection'
require 'noun-project-api/icon_retriever'
require 'noun-project-api/reporter'
require 'noun-project-api/icons_retriever'
require 'noun-project-api/icon'
require 'noun-project-api/collection_retriever'
require 'noun-project-api/collection'

# Top level name space for the entire Gem.
module NounProjectApi
  API_BASE = 'http://api.thenounproject.com'

  def self.configuration
    @configuration ||=  Configuration.new
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration) if block_given?
  end

  # Main configuration class.
  class Configuration
    attr_accessor :public_domain

    def initialize
      @public_domain = false
    end
  end
end
