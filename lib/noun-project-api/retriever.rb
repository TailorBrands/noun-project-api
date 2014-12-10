module NounProjectApi
  API_BASE = 'http://api.thenounproject.com'

  class Retriever
    attr_accessor :token, :secret, :access_token
    def initialize(token, secret)
      @token = token
      @secret = secret
      raise ArgumentError.new('Missing token or secret') unless @token && @secret

      @access_token = OAuth::AccessToken.new(OAuth::Consumer.new(token, secret))
    end
  end
end
