# frozen_string_literal: true

require "noun_project_api/retriever"

module NounProjectApi
  # Retrieve icons.
  class IconsRetriever < Retriever
    API_PATH = "/icons/"

    # Finds multiple icons based on the term
    # * term - search term
    # * limit - limit the amount of results
    # * offset - offset the results
    # * page - page number
    def find(term, limit = nil, offset = nil, page = nil)
      cache_key = Digest::MD5.hexdigest("#{term}+#{limit}+#{offset}+#{page}")

      NounProjectApi.configuration.cache.fetch(cache_key) do
        raise ArgumentError, "Missing search term" unless term

        search = OAuth::Helper.escape(term)
        search += "?limit_to_public_domain=#{NounProjectApi.configuration.public_domain ? 1 : 0}"

        args = {
          "limit" => limit,
          "offset" => offset,
          "page" => page
        }.reject { |_, v| v.nil? }
        args.each { |k, v| search += "&#{k}=#{v}" } unless args.empty?

        result = access_token.get("#{API_BASE}#{API_PATH}#{search}")
        raise ServiceError.new(result.code, result.body) unless ["200", "404"].include? result.code

        if result.code == "200"
          JSON.parse(result.body, symbolize_names: true)[:icons].map { |icon| Icon.new(icon) }
        else
          []
        end
      end
    end

    # List recent uploads
    # * limit - limit the amount of results
    # * offset - offset the results
    # * page - page number
    def recent_uploads(limit = nil, offset = nil, page = nil)
      args = {
        "limit" => limit,
        "offset" => offset,
        "page" => page
      }.reject { |_, v| v.nil? }
      if !args.empty?
        search = "?"
        args.each { |k, v| search += "#{k}=#{v}&" }
      else
        search = ""
      end

      result = access_token.get("#{API_BASE}#{API_PATH}recent_uploads#{search}")
      raise ServiceError.new(result.code, result.body) unless result.code == "200"

      JSON.parse(result.body, symbolize_names: true)[:recent_uploads].map { |icon| Icon.new(icon) }
    end
  end
end
