module NounProjectApi
  # Main class to hold reporting actions back to the Noun Project.
  class Reporter
    API_PATH = '/notify/publish'
    attr_accessor :token, :secret, :access_token

    def initialize(token, secret)
      @token = token
      @secret = secret
      fail(ArgumentError, 'Missing token or secret') unless @token && @secret

      @access_token = OAuth::AccessToken.new(OAuth::Consumer.new(token, secret))
    end

    def report_used(ids)
      ids = [ids] if ids.is_a?(String) || ids.is_a?(Fixnum)
      fail(ArgumentError, 'Missing ids') if ids.nil? || ids.empty?

      result = access_token.post("#{API_BASE}#{API_PATH}", icons: ids.join(','))
      result.code == '200'
    end
  end
end
