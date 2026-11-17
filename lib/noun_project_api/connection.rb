# frozen_string_literal: true

module NounProjectApi
  # Basic connection methods and setup.
  module Connection
    attr_accessor :token, :secret, :access_token

    def initialize(token, secret)
      @token = token
      @secret = secret
      raise ArgumentError, "Missing token or secret" unless @token && @secret

      # The consumer's site must match the API origin: oauth >= 1.1.9 refuses
      # signed requests to an absolute URL on any other origin.
      @access_token = OAuth::AccessToken.new(OAuth::Consumer.new(token, secret, site: API_BASE))
    end
  end
end
