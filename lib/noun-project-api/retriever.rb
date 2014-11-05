module NounProjectApi
  class Retriever
    attr_accessor :token, :secret
    def initialize(token, secret)
      @token = token
      @secret = secret
      raise ArgumentError unless @token && @secret
    end
  end
end
