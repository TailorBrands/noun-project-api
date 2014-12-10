require 'oauth'
require 'json'
require 'noun-project-api/icon_retriever'
require 'noun-project-api/icons_retriever'
require 'noun-project-api/icon'

module NounProjectApi
  def self.configuration
    @configuration ||=  Configuration.new
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration) if block_given?
  end

  class Configuration
    attr_accessor :public_domain

    def initialize
      @public_domain = false
    end
  end
end
