module NounProjectApi
  # A base class for different retriever classes.
  class Retriever
    attr_accessor :token, :secret, :access_token

    def initialize(token, secret)
      @token = token
      @secret = secret
      fail(ArgumentError, 'Missing token or secret') unless @token && @secret

      @access_token = OAuth::AccessToken.new(OAuth::Consumer.new(token, secret))
    end
  end
end
